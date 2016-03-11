require 'spec_helper'

describe ProjectsHelper do
  describe 'presenting the graphic of a metric' do
    before :each do
      @metric = double('metric')
      @data_hash = {:red => 9, :yellow => 9, :green => 6}
      expect(@metric).to receive(:get_data).and_return(@data_hash)
    end
    it 'should call the model method that retrieves the metric data' do
      graphic @metric
    end
    it 'should return some html with the class "graphic"' do
      expect(graphic(@metric)).to match(/.*?graphic.*?/)
    end
  end
end