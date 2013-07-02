Feature: Show version

  As a administrator 
  I want to get the version of the library
  In order to start in using the puppet generator

  Background: Process environment
    Given I set the environment variables to:
      | variable             | value |
      | PUPPET_GENERATOR_ENV | test  |

  Scenario: Show version via command line option
    When I successfully run `ppgen --version`
    Then the stdout should contain:
    """
    version
    """

  #Scenario: Show version via command
  #  When I successfully run `ppgen show version`
  #  Then the stdout should contain:
  #  """
  #  version
  #  """

