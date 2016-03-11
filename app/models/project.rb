class Project < ActiveRecord::Base
  has_one :pull_request
  has_one :slack_metric
end
