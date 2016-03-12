require 'spec_helper'

describe PullRequest do
  describe 'getting data' do
    # it 'should call the github client' do
    #   pending
    # end
    it 'should return a hash with keys red, yellow, green' do
      project = Project.create(git_repo: 'stevenbuccini/er-moonlighter-scheduler')
      pull_request = project.create_pull_request
      expect(pull_request.get_data[:red]).to be >= 0
      expect(pull_request.get_data[:yellow]).to be >= 0
      expect(pull_request.get_data[:green]).to be >= 0
    end
  end
end