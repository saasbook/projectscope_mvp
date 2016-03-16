require 'spec_helper'

describe PullRequestsHelper do
  describe 'presenting the graphic of a metric' do
    before :each do
      @metric = double('metric')
      @data_hash = {:red => 9, :yellow => 9, :green => 6}
      @metric.should_receive(:get_data).and_return(@data_hash)
    end
    it 'should call the model method that retrieves the metric data' do
      pull_request_graphic @metric
    end
    it 'should return some html with the class "graphic"' do
      expect(pull_request_graphic(@metric)).to match(/.*?pull_request_graphic.*?red.*?yellow.*?green.*?/)
    end
  end
end