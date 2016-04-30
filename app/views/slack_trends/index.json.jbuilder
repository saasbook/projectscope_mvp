json.array!(@slack_trends) do |slack_trend|
  json.extract! slack_trend, :id, :weekone, :weektwo, :weekthree, :project_id
  json.url slack_trend_url(slack_trend, format: :json)
end
