require 'spec_helper'

describe CodeClimateMetric do
    before :each do
        @url = 'https://codeclimate.com/github/dhhxu/projectscope/'
        @cc = CodeClimateMetric.create(url: @url)
    end
    describe '#coverage_url' do
        it 'should remove the trailing forward slash' do
            @cc.coverage_url
            expect(@cc.url).to eq(@url[0..-2])
        end
        
        it 'should return the url to the code climate coverage page' do
            expect(@cc.coverage_url).to eq(@url + 'coverage') 
        end
    end
    
    describe '#coverage_badge_url' do
        it 'should generate the correct link to the coverage badge svg' do
            expect(@cc.coverage_badge_url).to eq(@url + 'badges/coverage.svg') 
        end
    end
    
    describe '#gpa_badge_url' do
        it 'should generate the correct link to the gpa badge svg' do
            expect(@cc.gpa_badge_url).to eq(@url + 'badges/gpa.svg') 
        end
    end
end