class SlackTrend < ActiveRecord::Base
  belongs_to :project
  require 'date'
  
  def get_data
    # WILL NEED TO CHANGE LOCATION OF API TOKEN ONCE EACH PROJECT HAS ITS OWN
    client = Slack::Web::Client.new(token: self.slack_api_token)
    participation_total = 20.to_f # Max score for rating participation (Based on Gini Coefficient)
    msg_frequency_total = 50.to_f # Max score for msg frequency (At least 3 msgs per day)
    num_messages_total = 30.to_f # Max score for total of messages sent
    num_message_threshhold = 100 # Number of messages need to get MAX num_messages_total
    total_points_possible = participation_total+msg_frequency_total+num_messages_total # Decided on "out of 100" for simplicity
    users = client.users_list.members
    st_array = []
    
    # Iterate throught the number of weeks
    (1..3).each do |i|
      #Grade number of messages
      total_score = 0
      start_time = (Time.now - (7*i+Time.now.wday+1).days).to_s[0,10]
      end_time = (Time.now - (7*(i-1)+Time.now.wday).days).to_s[0,10]
      num_user_messages_array = []
      users.each do |user|
        unless user.name == "slackbot"
          num_user_messages = client.search_all(query: "from:@#{user.name} after:#{start_time} before:#{end_time}").messages.total
          num_user_messages_array<< num_user_messages
        end
      end
      num_messages_score = num_user_messages_array.inject{|sum,x| sum + x }
      if num_messages_score >= num_message_threshhold  # Rates the total amount messages
        total_score += num_messages_total
      else
        total_score += num_messages_score*(participation_total/num_message_threshhold)
      end
      
      #Grade frequency of messages
      (0..6).each do |d|
        day = (Time.now - (7*i+Time.now.wday+d).days).to_s[0,10]
        num_msgs_that_day = client.search_all(query: "on:#{day}").messages.total
        if num_msgs_that_day >= 3
          total_score += msg_frequency_total/7
        end
      end
      
      #Grade how equal were the messages distrubuted
      total_score += participation_total*(1-gini_coefficient(num_user_messages_array))
      
      total_score_normalized = (total_score*100/total_points_possible).round(0)
      
      if total_score_normalized > 100
        st_array<< 100
      else
        st_array<< total_score_normalized
      end
    end
    
    st_hash = {weekone: st_array[0], weektwo: st_array[1], weekthree: st_array[2]}
    self.update_attributes(st_hash)
    
  end
  
  def gini_coefficient(array)
    sorted = array.sort
    temp = 0.0
    n = sorted.length
    array_sum = array.inject(0){|sum,x| sum + x }
    (0..(n-1)).each do |i|
        temp += (n-i)*sorted[i]
    end
    return (n+1).to_f/ n - 2.0 * temp / ((array_sum)*n)
  end
  
  def message
    if self.weekone >= 0
      "Slack Grade: #{self.weekone}"
    else
      "Slack Grade: "
    end
  end
  
  
end
