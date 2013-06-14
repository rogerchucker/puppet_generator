Feature: Generate file definitions

  As a administrator 
  I need to write file definitions for puppet
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
    When I successfully run `ppgen create file`
    Then the file "out.d/asdf.pp" should contain:
    """
    class mymodule::asdf {
      file {'asdf':
        ensure => file,
      }
    }

    """

  Scenario: Non Existing Input File
    When I run `ppgen create file`
    Then the exit status should be 8
    And the stderr should contain "The file/directory \"input.txt\" does not exist"

  Scenario: Input via Stdin
    When I run `ppgen create file --source stdin` interactively
    And I type "asdf"
    And I close the stdin stream
    Then the file "out.d/asdf.pp" should contain:
    """
    class mymodule::asdf {
      file {'asdf':
        ensure => file,
      }
    }

    """

  Scenario: empty input source
    When I run `ppgen create file --source ''`
    Then the exit status should be 8
    And the stderr should contain "The file/directory \"\" does not exist."

  Scenario: Multiple lines in input file
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen create file`
    Then the file "out.d/asdf.pp" should contain:
    """
    class mymodule::asdf {
      file {'asdf':
        ensure => file,
      }
    }

    """
    And the file "out.d/test123.pp" should contain:
    """
    class mymodule::test123 {
      file {'test123':
        ensure => file,
      }
    }

    """

  Scenario: Module name given
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen create file --module string1::string2`
    Then the file "out.d/asdf.pp" should contain:
    """
    class string1::string2::asdf {
      file {'asdf':
        ensure => file,
      }
    }

    """

  Scenario: Multiple lines in input file with one output file
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen create file --destination file:out.txt`
    Then the file "out.txt" should contain:
    """
    class mymodule::myclass {
      file {'asdf':
        ensure => file,
      }
      file {'test123':
        ensure => file,
      }
    }

    """

  Scenario: Output to stdout
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen create file --destination stdout`
    Then the stdout should contain:
    """
    class mymodule::myclass {
      file {'asdf':
        ensure => file,
      }
    }

    """

  Scenario: Multiple lines in input file with one output file and one module definition
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen create file --destination file:out.txt --class test`
    Then the file "out.txt" should contain:
    """
    class mymodule::test {
      file {'asdf':
        ensure => file,
      }
      file {'test123':
        ensure => file,
      }
    }

    """

  Scenario: Real path with output to single file
    Given a file named "input.txt" with:
    """
    path/to/file
    """
    When I successfully run `ppgen create file --destination file:out.txt`
    Then the file "out.txt" should contain:
    """
    class mymodule::myclass {
      file {'path/to/file':
        ensure => file,
      }
    }

    """

  Scenario: Real path with output to multiple files
    Given a file named "input.txt" with:
    """
    path/to/file1
    """
    When I successfully run `ppgen create file --destination dir:out.d`
    Then the file "out.d/file1.pp" should contain:
    """
    class mymodule::file1 {
      file {'path/to/file1':
        ensure => file,
      }
    }

    """

  Scenario: With file system meta data
    Given a directory named "testdir"
    And an empty file named "testdir/file1" with mode "0644"
    And an empty file named "testdir/file2" with mode "0644"
    And an empty file named "testdir/file3" with mode "0644"
    When I successfully run `ppgen create file --source testdir --destination file:out.txt --export-filter filesystem_attributes`
    Then the file "out.txt" should contain:
    """
    class mymodule::myclass
    """
    And the file "out.txt" should contain:
    """
      file {'testdir':
    """
    And the file "out.txt" should contain:
    """
      file {'testdir/file1':
    """
    And the file "out.txt" should contain:
    """
      file {'testdir/file2':
    """
    And the file "out.txt" should contain:
    """
      file {'testdir/file3':
    """
    And the file "out.txt" should contain:
    """
      owner  =>
    """
    And the file "out.txt" should contain:
    """
      mode   => '100644',
    """

  Scenario: With file system meta data in separate files
    Given a directory named "testdir"
    And an empty file named "testdir/file1" with mode "0644"
    And an empty file named "testdir/file2" with mode "0644"
    And an empty file named "testdir/file3" with mode "0644"
    When I successfully run `ppgen create file --source testdir --export-filter filesystem_attributes`
    Then the file "out.d/file1.pp" should contain:
    """
      file {'testdir/file1':
        ensure => file,
    """
    Then the file "out.d/testdir.pp" should contain:
    """
      file {'testdir':
        ensure => directory,
    """
    Then the file "out.d/file3.pp" should contain:
    """
      file {'testdir/file3':
        ensure => file,
    """
    Then the file "out.d/file2.pp" should contain:
    """
      file {'testdir/file2':
        ensure => file,
    """
    Then the file "out.d/file2.pp" should contain:
    """
      mode   => '100644',
    """

  Scenario: Copy files afterwards
    Given a directory named "testdir"
    And a file named "testdir/file1" with:
    """
    asdf
    """
    And an empty file named "testdir/file2"
    And an empty file named "testdir/file3"
    When I successfully run `ppgen create module`
    And I successfully run `ppgen create file --source testdir --action copy_files_to_module_directory`
    Then a directory named "mymodule" should exist
    And a directory named "mymodule/files/testdir" should exist
    And the file "mymodule/files/testdir/file1" should contain:
    """
    asdf
    """

  Scenario: Copy files afterwards and handle errors
    And a file named "testfile1" with:
    """
    asdf
    """
    And I run `ppgen create file --source testfile1 --action copy_files_to_module_directory`
    Then the exit status should be 10
    And the stderr should contain "No such file or directory"

  Scenario: Fails if wrong action is chosen
    Given a directory named "testdir"
    When I run `ppgen create file --source testdir --action unknown_action`
    Then the exit status should be 7
    And the stderr should contain "unknown_action"

  Scenario: Use a tag to choose the correct template
    Given a file named "input.txt" with:
    """
    asdf1
    asdf2
    """
    When I successfully run `ppgen create file --template-tagged-with many_per_file --destination file:output.txt`
    Then the file "output.txt" should contain:
    """
    class mymodule::myclass {
      file {'asdf1':
        ensure => file,
      }
      file {'asdf2':
        ensure => file,
      }
    }

    """

  Scenario: Error if chosen a wrong combination
    Given a file named "input.txt" with:
    """
    asdf1
    asdf2
    """
    When I run `ppgen create file --template-tagged-with many_per_file`
    Then the exit status should be 9
    Then the stderr should contain:
    """
    I was not able to find a suitable template for the given command "file", for the given tags "many_per_file" and for the given destination "dir:out.d"
    """

  Scenario: Export filter null
    Given a file named "input.txt" with:
    """
    asdf1
    asdf2
    """
    And an empty file named "asdf1" with mode "644"
    When I successfully run `ppgen create file --export-filter null`
    Then the file "out.d/asdf1.pp" should contain:
    """
    class mymodule::asdf1 {
      file {'asdf1':
        ensure => file,
      }
    }

    """

  Scenario: Export filter filesystem attributes
    Given a file named "input.txt" with:
    """
    asdf1
    asdf2
    """
    And an empty file named "asdf1" with mode "0644"
    When I successfully run `ppgen create file --export-filter filesystem_attributes`
    Then the file "out.d/asdf1.pp" should contain:
    """
    class mymodule::asdf1 {
    """
    And the file "out.d/asdf1.pp" should contain:
    """
      file {'asdf1':
    """
    And the file "out.d/asdf1.pp" should contain:
    """
        ensure => file,
    """
    And the file "out.d/asdf1.pp" should contain:
    """
        owner  => 
    """
    And the file "out.d/asdf1.pp" should contain:
    """
        mode   => '100644',
    """
    And the file "out.d/asdf1.pp" should contain:
    """
      }
    """
    And the file "out.d/asdf1.pp" should contain:
    """
    }
    """
