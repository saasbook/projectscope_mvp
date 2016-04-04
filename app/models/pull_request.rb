class PullRequest < ActiveRecord::Base
  belongs_to :project
  
  def get_data
    client = Octokit::Client.new(:access_token => ENV['GITHUB_KEY'])
    repo = project.git_repo
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
    update(red, yellow, green)
    return  { :red => red,
              :yellow => yellow,
              :green => green
            }
  end
  
  def update(red, yellow, green)
     self.update_attributes(:red => red, :yellow => yellow, :green => green) 
  end
end
