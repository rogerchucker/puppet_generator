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
    class mymodule::yamltest {
      include one
      include two
    }
    class mymodule::yamltest2 {
      include one
      include two
    }

    """

  Scenario: Scan module
    Given a directory named "test"
    And a directory named "test/dir1"
    And an empty file named "test/dir1/file1.pp"
    And an empty file named "test/dir1/file2.pp"
    When I successfully run `ppgen create role --source test --destination dir:./ --export-filter build_role_includes_for_directory`
    Then the file "test.pp"" should contain:
    """
    class mymodule::Dir1 {
      include mymodule::Dir1::File1
      include mymodule::Dir1::File2
    }

    """
