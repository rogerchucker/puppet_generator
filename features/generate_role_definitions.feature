Feature: Generate role definitions

  As a administrator 
  I need to write role definitions for puppet
  In order to get those things up and running via puppet

  Scenario: Plain Input File
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen create role`
    Then the file "out.d/asdf.pp" should contain:
    """
    class mymodule::asdf {
    }

    """
