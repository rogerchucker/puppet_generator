Feature: Use tasks to make usage easier

  As a administrator 
  I need to use the puppet_generator a lot
  In order to get those things up and running via puppet

  Background: Process environment
    Given I set the environment variables to:
      | variable             | value |
      | PUPPET_GENERATOR_ENV | test  |

  Scenario: Scan module
    Given a directory named "test"
    And a directory named "test/dir1"
    And an empty file named "test/dir1/file1.pp"
    And an empty file named "test/dir1/file2.pp"
    When I successfully run `ppgen tasks create_roles_in_directory --source test --destination dir:./`
    Then the file "test/dir1.pp" should contain:
    """
    class mymodule::dir1 {
      include mymodule::dir1::file2
      include mymodule::dir1::file1
    }

    """
