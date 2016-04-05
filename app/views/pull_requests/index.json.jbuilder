json.array!(@pull_requests) do |pull_request|
  json.extract! pull_request, :id, :red, :yellow, :green, :project_id
  json.url project_pull_request_url(pull_request.project, pull_request, format: :json)
end
