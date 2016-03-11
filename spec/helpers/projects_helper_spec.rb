require 'spec_helper'

describe ProjectsHelper do
  describe 'presenting the graphic of a metric' do
    before :each do
      @pull_request = double('pull_request')
      @data_hash = {:red => 9, :yellow => 9, :green => 6}
      expect(@pull_request).to receive(:get_data).and_return(@data_hash)
    end
    it 'should call the model method that retrieves the metric data' do
      graphic @pull_request
    end
    it 'should return some html with the class "graphic"' do
      expect(graphic(@pull_request)).to match(/.*?graphic.*?/)
    end
  end
end