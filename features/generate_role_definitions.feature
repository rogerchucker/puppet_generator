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

  Scenario: Yaml Input File
    Given a file named "input.yml" with:
    """
    yaml_test:
      includes:
        - one
        - two
    yaml_test2:
      includes:
        - one
        - two
    """
    When I successfully run `ppgen create role --source input.yml --destination file:output.txt --import-filter yaml`
    Then the file "output.txt" should contain:
    """
    class mymodule::yaml_test {
      include one
      include two
    }
    class mymodule::yaml_test2 {
      include one
      include two
    }

    """
