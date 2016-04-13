class CodeClimateMetric < ActiveRecord::Base
    belongs_to :project
    
    require 'httparty'
    
    validates :url, url: true
    
    def get_data
        
    
    end
    
    def coverage_url
        fix_url
        self.url + '/coverage' 
    end
    
    def gpa_badge_url
        fix_url
        self.url + '/badges/gpa.svg'
    end
    
    def coverage_badge_url
        fix_url
        self.url + '/badges/coverage.svg'
    end
    
    private
    
    def fix_url
        # only works in the case there is a single trailing '/'
        # e.g. codeclimate.com/github/dhhxu/projectscope/
        if self.url[-1] == '/'
            self.update_attributes(:url => self.url[0..-2])
        end
    end
end
