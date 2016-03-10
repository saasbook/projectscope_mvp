json.array!(@projects) do |project|
  json.extract! project, :id, :name, :git_repo
  json.url project_url(project, format: :json)
end
