class SlackMetric < ActiveRecord::Base
  belongs_to :project
  
  def get_data
    client = Slack::Web::Client.new(token: ENV['SLACK_API_TOKEN'])
    users = client.users_list.members
    user_contributions = {}
    users.each do |user|
      user_contributions[user.name] = client.search_all(query: "from:@#{user.name}").messages.total
    end
    
    return total_messages = user_contributions.values.sum
    # user_contributions = user_contributions.inject({}) { |h, (k, v) | h[k] = v.to_f / total_messages; h }
    # avg_contribution = user_contributions.values.inject{ |sum, el| sum + el }.to_f / user_contributions.values.size
    # return avg_contribution
    # expected_contribution = 1.0 / users.length
    
    
  end

end
