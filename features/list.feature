#Feature: List things
#
#  As a administrator 
#  I want to get a list of available <resources>
#  In order to start in using the puppet generator
#
#  Background: Process environment
#    Given I set the environment variables to:
#      | variable             | value |
#      | PUPPET_GENERATOR_ENV | test  |
#
#  Scenario: List available ressources
#    When I successfully run `ppgen help list`
#    Then the output contains:
#    """
#    
#    """
#    Then the output contains:
#    """
#    exporter
#    """
#    Then the output contains:
#    """
#    importer
#    """
#    Then the output contains:
#    """
#    import_filter
#    """
#    Then the output contains:
#    """
#    export_filter
#    """
#    Then the output contains:
#    """
#    error_messages
#    """
