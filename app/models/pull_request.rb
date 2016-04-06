class PullRequest < ActiveRecord::Base
  belongs_to :project
  validates :red, :yellow, :green, presence: true
end
