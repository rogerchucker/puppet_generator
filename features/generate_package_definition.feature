Feature: Generate package definitions

  As a administrator 
  I need to write packages definitions for puppet
  In order to get those things up and running via puppet

  Scenario: Existing Input File
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen package`
    Then the file "out/asdf.pp" should contain:
    """
    class mymodule::asdf {

      package {'asdf':
        ensure => latest,
      }

    }

    """

  Scenario: Non Existing Input File
    When I run `ppgen package`
    Then the exit status should be 1
    And the stderr should contain "You entered an invalid source"

  Scenario: Input via Stdin
    When I run `ppgen package --source stdin` interactively
    And I type "asdf"
    And I close the stdin stream
    Then the file "out/asdf.pp" should contain:
    """
    class mymodule::asdf {

      package {'asdf':
        ensure => latest,
      }

    }

    """

  Scenario: Multiple lines in input file
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen package`
    Then the file "out/asdf.pp" should contain:
    """
    class mymodule::asdf {

      package {'asdf':
        ensure => latest,
      }

    }

    """
    And the file "out/test123.pp" should contain:
    """
    class mymodule::test123 {

      package {'test123':
        ensure => latest,
      }

    }

    """

  Scenario: Module name given
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen package --module string1::string2`
    Then the file "out/asdf.pp" should contain:
    """
    class string1::string2::asdf {

      package {'asdf':
        ensure => latest,
      }

    }

    """

  Scenario: Multiple lines in input file with one output file
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen package --output_channel file`
    Then the file "out" should contain:
    """
    class mymodule::asdf {

      package {'asdf':
        ensure => latest,
      }

    }

    class mymodule::test123 {

      package {'test123':
        ensure => latest,
      }

    }

    """

  Scenario: Output to stdout
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen package --output_channel stdout`
    Then the output should contain:
    """
    class mymodule::asdf {

      package {'asdf':
        ensure => latest,
      }

    }

    """

  Scenario: Multiple lines in input file with one output file and one module definition
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen package --output_channel file --template_class single --template_package plain --class test`
    Then the file "out" should contain:
    """
    class mymodule::test {

      package {'asdf':
        ensure => latest,
      }

    }

      package {'test123':
        ensure => latest,
      }

    }

    """
