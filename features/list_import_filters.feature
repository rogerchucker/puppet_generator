Feature: List import_filters

  As a administrator 
  I want to get a list of available import_filters
  In order to start in using the puppet generator

  Background: Process environment
    Given I set the environment variables to:
      | variable             | value |
      | PUPPET_GENERATOR_ENV | test  |

  Scenario: List available resources
    When I successfully run `ppgen help list`
    Then the stdout should contain:
    """
    import_filters
    """

  Scenario: List available import_filters
    When I successfully run `ppgen list import_filters`
    Then the stdout should contain:
    """
    ┌────────┐
    │ name   │
    ├────────┤
    │ null   │
    │ passwd │
    │ yaml   │
    └────────┘
    """

  #Scenario: List available import_filters for the user resource
  #  When I successfully run `ppgen list import_filters --filter user`
  #  Then the stdout should contain:
  #  """
  #  ┌───────┐
  #  │ name  │
  #  ├───────┤
  #  │ file  │
  #  │ stdin │
  #  └───────┘
  #  """

  #Scenario: List available import_filters for the package resource
  #  When I successfully run `ppgen list import_filters --filter package`
  #  Then the stdout should contain:
  #  """
  #  ┌───────┐
  #  │ name  │
  #  ├───────┤
  #  │ file  │
  #  │ stdin │
  #  └───────┘
  #  """

  #Scenario: List available import_filters for the file resource
  #  When I successfully run `ppgen list import_filters --filter file`
  #  Then the stdout should contain:
  #  """
  #  ┌───────────┐
  #  │ name      │
  #  ├───────────┤
  #  │ file      │
  #  │ directory │
  #  │ stdin     │
  #  └───────────┘
  #  """

  #Scenario: List available import_filters for multiple resource types 
  #  When I successfully run `ppgen list import_filters --filter package user file`
  #  Then the stdout should contain:
  #  """
  #  ┌───────────┐
  #  │ name      │
  #  ├───────────┤
  #  │ file      │
  #  │ directory │
  #  │ stdin     │
  #  └───────────┘
  #  """
