Feature: pr graphic

  As an instructor
  So that I can tell which projects are utilizing git correctly
  I want to see a horizontal stacked bar graph representing the break down of
    unreviewed and reviewed pull requests

Scenario: view pull requests graphic on home page
  Given I create a new project named "Spillio" with the git repo "TheArchitects/Spillio"
  And I am on the home page
  Then I should see the "Spillio" pull request graphic
  And I should see the total number of pull requests for "Spillio"
  And I should see the "Spillio" pull request trends graphic
