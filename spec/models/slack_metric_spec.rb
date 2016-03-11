require 'spec_helper'

describe SlackMetric do
  describe 'getting data' do
    before :each do
      @slack_metric = SlackMetric.create
    end
    # it 'should call the slack client' do
    #   client = double('client')
    #   client.should_receive(:search_all)#.with(query: 'from:@tyler')
    #   @slack_metric.get_data
    # end
    it 'should return a positive number' do
      actual = @slack_metric.get_data
      expect(actual).to be >= 0
    end
  end
end