Feature: Generate module directories definitions

  As a administrator 
  I need to create a module for puppet
  In order to get those things up and running via puppet

  Background: Process environment
    Given I set the environment variables to:
      | variable             | value |
      | PUPPET_GENERATOR_ENV | test  |

  Scenario: predefined module name
    When I successfully run `ppgen create module`
    Then a directory named "mymodule" should exist
    And a directory named "mymodule/manifests" should exist
    And a directory named "mymodule/files" should exist
    And the file "mymodule/manifests/init.pp" should contain:
    """
    class mymodule {

    }

    """

  Scenario: Different name for module
    When I successfully run `ppgen create module --module testmodule`
    Then a directory named "testmodule" should exist
    And a directory named "testmodule/manifests" should exist
    And a directory named "testmodule/files" should exist
    And the file "testmodule/manifests/init.pp" should contain:
    """
    class testmodule {

    }

    """
