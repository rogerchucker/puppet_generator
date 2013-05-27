Feature: Generate file definitions

  As a administrator 
  I need to write file definitions for puppet
  In order to get those things up and running via puppet

  @wip
  Scenario: Plain Input File
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen file`
    Then the file "out/asdf.pp" should contain:
    """
    class mymodule::asdf {

      file {'asdf':
        ensure => file,
        source => 'puppet:///mymodule/asdf',
        owner  => 'root',
        mode   => '0644',
      }

    }

    """

#  Scenario: Non Existing Input File
#    When I run `ppgen package`
#    Then the exit status should be 1
#    And the stderr should contain "You entered an invalid source"
#
#  Scenario: Input via Stdin
#    When I run `ppgen package --source stdin` interactively
#    And I type "asdf"
#    And I close the stdin stream
#    Then the file "out/asdf.pp" should contain:
#    """
#    class mymodule::asdf {
#      package {'asdf':
#        ensure => latest,
#      }
#    }
#
#    """
#
#  Scenario: Multiple lines in input file
#    Given a file named "input.txt" with:
#    """
#    asdf
#    test123
#    """
#    When I successfully run `ppgen package`
#    Then the file "out/asdf.pp" should contain:
#    """
#    class mymodule::asdf {
#      package {'asdf':
#        ensure => latest,
#      }
#    }
#
#    """
#    And the file "out/test123.pp" should contain:
#    """
#    class mymodule::test123 {
#      package {'test123':
#        ensure => latest,
#      }
#    }
#
#    """
#
#  Scenario: Module name given
#    Given a file named "input.txt" with:
#    """
#    asdf
#    """
#    When I successfully run `ppgen package --module string1::string2`
#    Then the file "out/asdf.pp" should contain:
#    """
#    class string1::string2::asdf {
#      package {'asdf':
#        ensure => latest,
#      }
#    }
#
#    """
#
#  Scenario: Multiple lines in input file with one output file
#    Given a file named "input.txt" with:
#    """
#    asdf
#    test123
#    """
#    When I successfully run `ppgen package --destination file:out.txt`
#    Then the file "out.txt" should contain:
#    """
#    class mymodule::myclass {
#      package {'asdf':
#        ensure => latest,
#      }
#      package {'test123':
#        ensure => latest,
#      }
#    }
#
#    """
#
#  Scenario: Output to stdout
#    Given a file named "input.txt" with:
#    """
#    asdf
#    """
#    When I successfully run `ppgen package --destination stdout`
#    Then the output should contain:
#    """
#    class mymodule::asdf {
#      package {'asdf':
#        ensure => latest,
#      }
#    }
#
#    """
#
#  Scenario: Multiple lines in input file with one output file and one module definition
#    Given a file named "input.txt" with:
#    """
#    asdf
#    test123
#    """
#    When I successfully run `ppgen package --destination file:out.txt --class test`
#    Then the file "out.txt" should contain:
#    """
#    class mymodule::test {
#      package {'asdf':
#        ensure => latest,
#      }
#      package {'test123':
#        ensure => latest,
#      }
#    }
#
#    """
