require 'spec_helper'

describe PullRequest do
  describe 'getting data' do
    it 'should return a hash with keys red, yellow, green' do
      project = Project.create(git_repo: 'stevenbuccini/er-moonlighter-scheduler')
      pull_request = project.create_pull_request
      result = pull_request.get_data
      expect(result).to be_an_instance_of(Hash)
      expect(result[:red]).to be >= 0
      expect(result[:yellow]).to be >= 0
      expect(result[:green]).to be >= 0
    end
  end
end