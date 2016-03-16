require 'spec_helper'

describe SlackMetric do
  describe 'getting data' do
    it 'should return a hash of non-negative numbers' do
      slack_metric = SlackMetric.create
      result = slack_metric.get_data
      expect(result).to be_an_instance_of(Hash)
      result.each_value do |value|
        expect(value).to be >= 0
      end
    end
  end
end