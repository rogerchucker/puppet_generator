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
    │ file      │
    │ directory │
    │ stdin     │
    └───────────┘
    """

  #Scenario: List available actions for the user resource
  #  When I successfully run `ppgen list actions --filter user`
  #  Then the stdout should contain:
  #  """
  #  ┌──────┐
  #  │ name │
  #  ├──────┤
  #  │ null │
  #  └──────┘
  #  """

  #Scenario: List available actions for the package resource
  #  When I successfully run `ppgen list actions --filter package`
  #  Then the stdout should contain:
  #  """
  #  ┌──────┐
  #  │ name │
  #  ├──────┤
  #  │ null │
  #  └──────┘
  #  """

  #Scenario: List available actions for the file resource
  #  When I successfully run `ppgen list actions --filter file`
  #  Then the stdout should contain:
  #  """
  #  ┌────────────────────────────────┐
  #  │ name                           │
  #  ├────────────────────────────────┤
  #  │ null                           │
  #  │ copy_files_to_module_directory │
  #  └────────────────────────────────┘
  #  """

  #Scenario: List available actions for multiple resource types 
  #  When I successfully run `ppgen list actions --filter package user file`
  #  Then the stdout should contain:
  #  """
  #  ┌────────────────────────────────┐
  #  │ name                           │
  #  ├────────────────────────────────┤
  #  │ null                           │
  #  │ copy_files_to_module_directory │
  #  └────────────────────────────────┘
  #  """
