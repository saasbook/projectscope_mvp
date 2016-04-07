class Project < ActiveRecord::Base
  has_one :pull_request
  has_many :slack_data_points
  
  def get_pull_request_data
    begin
      client = Octokit::Client.new(:access_token => ENV['GITHUB_KEY'])
      if self.git_repo =~ /(.+)(\/|\.git)$/
        repo = $1
      else
        repo = self.git_repo
      end
      
      client.auto_paginate = true
      
      comments = client.pull_requests_comments repo
      closed_prs = client.pulls repo, :state => 'closed'
      open_prs = client.pulls repo, :state => 'open'
      total_prs = closed_prs.length + open_prs.length
      
      comments_hash = {}
      comments.each do |comment|
          url = comment.pull_request_url
          regex = /^https:\/\/api.github.com\/repos\/[^\/]+\/[^\/]+\/pulls\/(\d+)$/
          if url =~ regex
              pull_no = $1
          end
          pull_no = pull_no.to_i
          
          if comments_hash.has_key? pull_no
              comments_hash[pull_no] += 1
          else
              comments_hash[pull_no] = 1
          end
      end
      
      yellow_cutoff = 1
      green_cutoff = 2
      
      pulls_with_comments = comments_hash.values
      red = total_prs - pulls_with_comments.length
      yellow = pulls_with_comments.count {|x| x == yellow_cutoff}
      green = pulls_with_comments.count {|x| x >= green_cutoff}
      
      pr_hash = {red: red, yellow: yellow, green: green}
    rescue Octokit::InvalidRepository, Octokit::NotFound
      pr_hash = {red: -1, yellow: -1, green: -1}
    ensure
      if self.pull_request
        self.pull_request.update_attributes(pr_hash)
      else
        self.create_pull_request(pr_hash)
      end
    end
  end
  
  def get_slack_data
    client = Slack::Web::Client.new(token: ENV['SLACK_API_TOKEN'])
    users = client.users_list.members
    users.each do |user|
      unless user.name == "slackbot"
        num_messages = client.search_all(query: "from:@#{user.name}").messages.total
        slack_data_point = self.slack_data_points.find_by user: user.name
        if slack_data_point
          slack_data_point.update_attributes(:messages => num_messages)
        else
          self.slack_data_points.create(user: user.name, messages: num_messages)
        end
      end
    end
  end

end
