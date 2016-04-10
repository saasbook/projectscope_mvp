require 'spec_helper'

describe PullRequestsController do
    describe 'PullRequestsController#show json' do
        it 'should make the appropriate pull request object available to the json templating machine' do
            proj = Project.create(name: 'Splillio')
            proj.create_pull_request(repo: 'TheArchitects/Spillio')
            proj.pull_request.get_data
            get :show, {:project_id => proj.id, :id => proj.pull_request.id}
            expect(assigns(:pull_request)).to eql(proj.pull_request)
        end
    end
end