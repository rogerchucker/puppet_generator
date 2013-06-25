Feature: List importers

  As a administrator 
  I want to get a list of available importers
  In order to start in using the puppet generator

  Background: Process environment
    Given I set the environment variables to:
      | variable             | value |
      | PUPPET_GENERATOR_ENV | test  |

  Scenario: List available resources
    When I successfully run `ppgen help list`
    Then the stdout should contain:
    """
    importers
    """

  Scenario: List available importers
    When I successfully run `ppgen list importers`
    Then the stdout should contain:
    """
    ┌───────────┐
    │ name      │
    ├───────────┤
    │ directory │
    │ file      │
    │ stdin     │
    └───────────┘
    """

  Scenario: List available importers for the user resource
    When I successfully run `ppgen list importers --filter user`
    Then the stdout should contain:
    """
    ┌───────┐
    │ name  │
    ├───────┤
    │ file  │
    │ stdin │
    └───────┘
    """

  Scenario: List available importers for the package resource
    When I successfully run `ppgen list importers --filter package`
    Then the stdout should contain:
    """
    ┌───────┐
    │ name  │
    ├───────┤
    │ file  │
    │ stdin │
    └───────┘
    """

  Scenario: List available importers for the file resource
    When I successfully run `ppgen list importers --filter file`
    Then the stdout should contain:
    """
    ┌───────────┐
    │ name      │
    ├───────────┤
    │ directory │
    │ file      │
    │ stdin     │
    └───────────┘
    """

  Scenario: List available importers for multiple resource types 
    When I successfully run `ppgen list importers --filter package user file`
    Then the stdout should contain:
    """
    ┌───────────┐
    │ name      │
    ├───────────┤
    │ directory │
    │ file      │
    │ stdin     │
    └───────────┘
    """
