class SlackMetric < ActiveRecord::Base
  belongs_to :project
  has_many :slack_data_points
  
  def get_data
    client = Slack::Web::Client.new(token: self.slack_api_token)
    users = client.users_list.members
    start_time = (Time.now - (7+Time.now.wday+1).days).to_s[0,10]
      end_time = (Time.now - (Time.now.wday).days).to_s[0,10]
    users.each do |user|
      unless user.name == "slackbot"
        num_messages = client.search_all(query: "from:@#{user.name} after:#{start_time} before:#{end_time}").messages.total
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
