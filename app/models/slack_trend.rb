class SlackTrend < ActiveRecord::Base
  belongs_to :project
  require 'date'
  
  def get_data
    # WILL NEED TO CHANGE LOCATION OF API TOKEN ONCE EACH PROJECT HAS ITS OWN
    puts '==================================================================='
    client = Slack::Web::Client.new(token: ENV['SLACK_API_TOKEN'])
    participation_total = 50 # Max score for rating participation (Based on Standard Deviation)
    num_messages_total = 50 # Max score for total of messages sent
    num_message_threshhold = 50 # Number of messages need to get MAX num_messages_total
    total_points_possible = participation_total+num_messages_total # Decided on "out of 100" for simplicity
    num_weeks = 3 # Number of weeks to get data from
    users = client.users_list.members
    st_array = []
    
    # Iterate throught the number of weeks
    (1..num_weeks).each do |i|
      z = 7*i-Time.now.wday-1
      puts "----------------------------#{z}"
      total_score = 0
      start_time = (Time.now - (7*i+Time.now.wday+1).days).to_s[0,10]
      end_time = (Time.now - (7*i+Time.now.wday-6).days).to_s[0,10]
      puts "start: #{start_time}       end: #{end_time}"
      num_messages_score = client.search_all(query: "after:#{start_time} before:#{end_time}").messages.total
      puts "Num_msg_score: #{num_messages_score}"
      if num_messages_score >= num_message_threshhold  # Rates the total amount messages
        total_score += num_messages_total
      else
        total_score += num_messages_score
      end
      puts "total score: #{total_score}"
      
      num_user_messages_array = []
      users.each do |user|
        unless user.name == "slackbot"
          num_user_messages = client.search_all(query: "from:@#{user.name} after:#{start_time} before:#{end_time}").messages.total
          num_user_messages_array<< num_user_messages
        end
      end
      
      puts "Array: #{num_user_messages_array}"
      
      num_of_users = num_user_messages_array.length
      array_sum = num_user_messages_array.inject(0){|sum,x| sum + x }
      mean = array_sum/num_of_users
      std_dev = num_user_messages_array.stdev
      num_user_messages_array.each do |j|
        case
        when j >= mean-std_dev
          total_score += participation_total/num_of_users
        when j < mean-std_dev && j >= mean-2*std_dev
          total_score += participation_total/(2*num_of_users)
        end
      end
      
      puts total_score
      total_score_normalized = (total_score*100/total_points_possible).round(0)
      puts total_score_normalized
      
      if total_score_normalized > 100
        st_array<< 100
      else
        st_array<< total_score_normalized
      end
    end
    
    puts st_array
    
    st_hash = {weekone: st_array[0], weektwo: st_array[1], weekthree: st_array[2]}
    self.update_attributes(st_hash)
    
  end
end
