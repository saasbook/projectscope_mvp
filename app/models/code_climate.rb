class CodeClimate < ActiveRecord::Base
    belongs_to :project
    
    validates :url, url: true
    
    def get_data
        
    
    end
    
    def image_url:
         
    end
end
