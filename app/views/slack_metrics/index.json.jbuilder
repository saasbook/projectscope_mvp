json.array!(@slack_metrics) do |slack_metric|
  json.extract! slack_metric, :id, :slack_api_token, :project_id
  json.url project_slack_metric_url(slack_metric.project, slack_metric, format: :json)
end
