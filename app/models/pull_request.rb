class PullRequest < ActiveRecord::Base
  belongs_to :project
  
  def get_data
  end

end
