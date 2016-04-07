class SlackDataPoint < ActiveRecord::Base
  belongs_to :slack_metric
  has_one :project, through: :slack_metric
end
