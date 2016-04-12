class CodeClimate < ActiveRecord::Base
    belongs_to :project
    
    validates :url, url: true
end
