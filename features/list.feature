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
    Then the output contains:
    """
    resources
    exporter
    importer
    import_filter
    export_filter
    """

