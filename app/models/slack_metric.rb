class SlackMetric < ActiveRecord::Base
  belongs_to :project
  
  def get_data
    client = Slack::Web::Client.new(token: ENV['SLACK_API_TOKEN'])
    users = client.users_list.members
    user_contributions = {}
    users.each do |user|
      user_contributions[user.name] = client.search_all(query: "from:@#{user.name}").messages.total
    end
    
    return user_contributions.values.sum
  end
end
