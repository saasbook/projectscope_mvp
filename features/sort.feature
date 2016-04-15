Feature: sort projects by metrics

  As an instructor
  So that I can see which projects are doing better in which project metrics
  I want to be able to sort projects based on each of the metrics

Scenario: sort by pull requests
  Given the following projects exist:
  | name                | repo                  |
  | Splillio            | TheArchitects/Spillio |
  | TeaTracker          | dwroth/TeaTracker     |
  | Fruitful Minds      | juliaoh/fruitfulminds |
  | FuelEd              | FuelEdAdmin/FuelEd    |
  | Kuansim - "To Care" | g0v/kuansim-rails     |
  | CalTeach            | joshlam/calteach      |

  And I am on the home page
  When I follow "Pull Requests"
  Then the projects should be sorted by pull requests
