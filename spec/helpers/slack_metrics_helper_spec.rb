require 'spec_helper'

describe SlackMetricsHelper do
  describe 'presenting the graphic of a metric' do
    before :each do
      @metric = double('metric')
      @data_hash = {'adam' => 0, 'arnold' => 1, 'daniel' => 2, 'manuk' => 3, 'patrick' => 4, 'tyler' => 5}
      @metric.should_receive(:get_data).and_return(@data_hash)
    end
    it 'should call the model method that retrieves the metric data' do
      slack_graphic @metric
    end
    it 'should return some html with the class "graphic"' do
      expect(slack_graphic(@metric)).to match(/.*?slack_graphic.*?(red)?.*?(orange)?.*?(yellow)?.*?(green)?.*?/)
    end
  end
end