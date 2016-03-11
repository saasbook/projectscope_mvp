Then(/^I should see a graphic representing (.*?) metrics in a row of the projects table$/) do |metric|
  page.should have_content(metric)
  page.should have_xpath('//tr/td[@class="graphic"]')
end