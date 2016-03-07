class Project < ActiveRecord::Base
    
    validates :name, :presence => true
    validates :git_repo, :presence => true
    
end
