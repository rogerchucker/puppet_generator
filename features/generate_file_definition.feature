Feature: Generate file definitions

  As a administrator 
  I need to write file definitions for puppet
  In order to get those things up and running via puppet

  Scenario: Plain Input File
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen file`
    Then the file "out.d/asdf.pp" should contain:
    """
    class mymodule::asdf {
      file {'asdf':
        ensure => file,
      }
    }

    """

  Scenario: Non Existing Input File
    When I run `ppgen file`
    Then the exit status should be 1
    And the stderr should contain "You entered an invalid source"

  Scenario: Input via Stdin
    When I run `ppgen file --source stdin` interactively
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

  Scenario: Multiple lines in input file
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen file`
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
    When I successfully run `ppgen file --module string1::string2`
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
    When I successfully run `ppgen file --destination file:out.txt`
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
    When I successfully run `ppgen file --destination stdout`
    Then the output should contain:
    """
    class mymodule::asdf {
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
    When I successfully run `ppgen file --destination file:out.txt --class test`
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
    When I successfully run `ppgen file --destination file:out.txt`
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
    When I successfully run `ppgen file --destination dir:out`
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
    And an empty file named "testdir/file1"
    And an empty file named "testdir/file2"
    And an empty file named "testdir/file3"
    When I successfully run `ppgen file --source testdir --destination file:out.txt`
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

    @wip
  Scenario: With file system meta data in separate files
    Given a directory named "testdir"
    And an empty file named "testdir/file1"
    And an empty file named "testdir/file2"
    And an empty file named "testdir/file3"
    When I successfully run `ppgen file --source testdir`
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
