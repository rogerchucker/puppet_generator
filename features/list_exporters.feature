Feature: List exporter

  As a administrator 
  I want to get a list of available <resources>
  In order to start in using the puppet generator

  Background: Process environment
    Given I set the environment variables to:
      | variable             | value |
      | PUPPET_GENERATOR_ENV | test  |

  Scenario: List available resources
    When I successfully run `ppgen help list`
    Then the stdout should contain:
    """
    exporters
    """

  Scenario: List available exporters
    When I successfully run `ppgen list exporters`
    Then the stdout should contain:
    """
    ┌───────────┐
    │ name      │
    ├───────────┤
    │ file      │
    │ directory │
    │ stdout    │
    └───────────┘
    """
  
