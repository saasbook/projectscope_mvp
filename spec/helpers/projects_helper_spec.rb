require 'spec_helper'

describe ProjectsHelper do
    before :each do
        @repo_name = 'dhhxu/projectscope' 
    end
    describe '#github_url' do
        it 'should return proper github url' do
            repo_name = 'dhhxu/projectscope'
            expected = "https://github.com/dhhxu/projectscope"
            expect(helper.github_url repo_name).to eq(expected)
        end
    end
    
    describe '#url_exist?' do
        before :each do
            @url = helper.github_url(@repo_name) 
        end
        it 'should return true for a valid url' do
            expect(helper.url_exist? @url).to eq(true)
        end
    
        it 'should return false for a invalid url' do
            bad_url = @url + "asdf"
            expect(helper.url_exist? bad_url).to eq(false)
        end
    end
    
    
end