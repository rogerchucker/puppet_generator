Feature: Generate module directories definitions

  As a administrator 
  I need to create a module for puppet
  In order to get those things up and running via puppet

  Scenario: predefined module name
    When I successfully run `ppgen module`
    Then a directory named "mymodule" should exist
    And a directory named "mymodule/manifests" should exist
    And a directory named "mymodule/manifests" should exist
    And the file "mymodule/init.pp" should contain:
    """
    class mymodule {

    }

    """

  Scenario: Different name for module
    When I successfully run `ppgen module --module test_module`
    Then a directory named "test_module" should exist
    And a directory named "test_module/manifests" should exist
    And a directory named "test_module/manifests" should exist
    And the file "test_module/init.pp" should contain:
    """
    class test_module {

    }

    """
