Feature: pull requests

  As an instructor
  So that I can see whether project developement is progressing smoothly
  I want to see the ratio of total pull requests to those that have been
    reviewed by the team

Scenario: view pull requests graphic on home page
  Given I am on the home page
  Then I should see a graphic representing Pull Requests metrics in a row of the projects table
