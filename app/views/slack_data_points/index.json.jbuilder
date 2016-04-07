json.array!(@slack_data_points) do |slack_data_point|
  json.extract! slack_data_point, :id, :user, :messages, :slack_metric_id
  json.url project_slack_data_point_url(slack_data_point.project, slack_data_point, format: :json)
end
