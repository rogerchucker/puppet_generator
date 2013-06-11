Feature: Generate module directories definitions

  As a administrator 
  I need to create a module for puppet
  In order to get those things up and running via puppet

  Scenario: predefined module name
    When I successfully run `ppgen create module`
    Then a directory named "Mymodule" should exist
    And a directory named "Mymodule/manifests" should exist
    And a directory named "Mymodule/manifests" should exist
    And the file "Mymodule/init.pp" should contain:
    """
    class Mymodule {

    }

    """

  Scenario: Different name for module
    When I successfully run `ppgen create module --module test_module`
    Then a directory named "test_module" should exist
    And a directory named "test_module/manifests" should exist
    And a directory named "test_module/manifests" should exist
    And the file "test_module/init.pp" should contain:
    """
    class test_module {

    }

    """
