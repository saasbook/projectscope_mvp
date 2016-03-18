Feature: Test Coverage
  As an instructor
  So that I can tell whether a project group’s test suite adequately covers
    their code
  I want to see their badge from Travis CI
  
Scenario: view Travis CI badge on home page
  Given I am on the home page
  Then I should see their badge from Travis CI