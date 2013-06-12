Feature: Generate role definitions

  As a administrator 
  I need to write role definitions for puppet
  In order to get those things up and running via puppet

  Background: Process environment
    Given I set the environment variables to:
      | variable             | value |
      | PUPPET_GENERATOR_ENV | test  |

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
      include mymodule::yaml_test::one
      include mymodule::yaml_test::two
    }
    class mymodule::yaml_test2 {
      include mymodule::yaml_test2::one
      include mymodule::yaml_test2::two
    }

    """

  Scenario: Scan module
    Given a directory named "test"
    And a directory named "test/dir1"
    And an empty file named "test/dir1/file1.pp"
    And an empty file named "test/dir1/file2.pp"
    When I successfully run `ppgen create role --source test --destination dir:./ --export-filter build_role_includes_for_directory`
    Then the file "test/dir1.pp" should contain:
    """
    class mymodule::dir1 {
      include mymodule::dir1::file1
      include mymodule::dir1::file2
    }

    """
