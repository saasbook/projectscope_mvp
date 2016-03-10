Feature: slack

  As an instructor
  So that I can gauge a group's communication
  I want to see a "heat measure" (a color coded scalar) of the distribution of
    slack contributions among team members

Scenario: view slack graphic on home page
  Given I am on the home page
  Then I should see a graphic representing slack metrics in a row of the projects table
