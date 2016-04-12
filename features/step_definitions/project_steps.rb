Then(/^I should see a graphic representing (.*?) metrics in a row of the projects table$/) do |metric|
  page.should have_content(metric)
  # page.should have_xpath("//td/div[@class='graphic']")
end

Then /^I should see a graphic showing (.*)$/ do |thing|
  fail "Unimplemented"
end

Then /^I should see their badge from (.*)$/ do |service|
  # Figure this out for Iteration 2-2
  fail "Unimplemented"
end

Given(/^I create a new project named "([^"]*)" with the git repo "([^"]*)"$/) do |project_name, repo_name|
  proj = Project.create(name: project_name)
  proj.create_pull_request(repo: repo_name)
end

Then(/^I should see the "([^"]*)" (.*) graphic$/) do |project_name, metric|
  project_id = Project.find_by(name: project_name).id
  expect(page).to have_selector('#'+ project_id.to_s + '-' + metric.gsub(' ', '-'))
end

Then(/^I should see the total number of pull requests for "([^"]*)"$/) do |project_title|
  project_id = Project.
end
