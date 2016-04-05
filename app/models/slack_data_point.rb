class SlackDataPoint < ActiveRecord::Base
  belongs_to :slack_metric
end
