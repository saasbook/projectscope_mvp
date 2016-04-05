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
