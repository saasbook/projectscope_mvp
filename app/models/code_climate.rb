class CodeClimate < ActiveRecord::Base
    belongs_to :pull_request
end
