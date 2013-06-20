Feature: List things

  As a administrator 
  I want to get a list of available <resources>
  In order to start in using the puppet generator

  Background: Process environment
    Given I set the environment variables to:
      | variable             | value |
      | PUPPET_GENERATOR_ENV | test  |

  Scenario: List available ressources
    When I successfully run `ppgen help list`
    #Then the stdout should contain:
    #"""
    #exporters
    #"""
    #Then the stdout should contain:
    #"""
    #importers
    #"""
    #Then the stdout should contain:
    #"""
    #import_filters
    #"""
    #Then the stdout should contain:
    #"""
    #export_filters
    #"""
    #Then the stdout should contain:
    #"""
    #error_messages
    #"""
    Then the stdout should contain:
    """
    actions
    """

  Scenario: List available actions
    When I successfully run `ppgen list actions`
    Then the stdout should contain:
    """
    ┌────────────────────────────────┐
    │ name                           │
    ├────────────────────────────────┤
    │ null                           │
    │ copy_files_to_module_directory │
    └────────────────────────────────┘
    """

  Scenario: List available actions for the user ressource
    When I successfully run `ppgen list actions --filter user`
    Then the stdout should contain:
    """
    ┌──────┐
    │ name │
    ├──────┤
    │ null │
    └──────┘
    """

  Scenario: List available actions for the package ressource
    When I successfully run `ppgen list actions --filter package`
    Then the stdout should contain:
    """
    ┌──────┐
    │ name │
    ├──────┤
    │ null │
    └──────┘
    """

  Scenario: List available actions for the file ressource
    When I successfully run `ppgen list actions --filter file`
    Then the stdout should contain:
    """
    ┌────────────────────────────────┐
    │ name                           │
    ├────────────────────────────────┤
    │ null                           │
    │ copy_files_to_module_directory │
    └────────────────────────────────┘
    """
