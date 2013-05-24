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
    class development::apps::asdf {

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
    class development::apps::asdf {

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
    class development::apps::asdf {

      package {'asdf':
        ensure => latest,
      }

    }

    """
    And the file "out/test123.pp" should contain:
    """
    class development::apps::test123 {

      package {'test123':
        ensure => latest,
      }

    }

    """

  Scenario: Class name given
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen package --class string1::string2`
    Then the file "out/asdf.pp" should contain:
    """
    class string1::string2::asdf {

      package {'asdf':
        ensure => latest,
      }

    }

    """
