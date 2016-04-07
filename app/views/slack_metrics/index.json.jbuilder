json.array!(@slack_metrics) do |slack_metric|
  json.extract! slack_metric, :id, :slack_api_token
  json.url slack_metric_url(slack_metric, format: :json)
end
