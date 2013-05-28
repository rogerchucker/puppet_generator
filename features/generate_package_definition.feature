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
    Then the file "out.d/asdf.pp" should contain:
    """
    class mymodule::asdf {
      package {'asdf':
        ensure   => installed,
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
    Then the file "out.d/asdf.pp" should contain:
    """
    class mymodule::asdf {
      package {'asdf':
        ensure   => installed,
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
    Then the file "out.d/asdf.pp" should contain:
    """
    class mymodule::asdf {
      package {'asdf':
        ensure   => installed,
      }
    }

    """
    And the file "out.d/test123.pp" should contain:
    """
    class mymodule::test123 {
      package {'test123':
        ensure   => installed,
      }
    }

    """

  Scenario: Module name given
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen package --module string1::string2`
    Then the file "out.d/asdf.pp" should contain:
    """
    class string1::string2::asdf {
      package {'asdf':
        ensure   => installed,
      }
    }

    """

  Scenario: Multiple lines in input file with one output file
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen package --destination file:out.txt`
    Then the file "out.txt" should contain:
    """
    class mymodule::myclass {
      package {'asdf':
        ensure   => installed,
      }
      package {'test123':
        ensure   => installed,
      }
    }

    """

  Scenario: Output to stdout
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen package --destination stdout`
    Then the output should contain:
    """
    class mymodule::asdf {
      package {'asdf':
        ensure   => installed,
      }
    }

    """

  Scenario: Multiple lines in input file with one output file and one module definition
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen package --destination file:out.txt --class test`
    Then the file "out.txt" should contain:
    """
    class mymodule::test {
      package {'asdf':
        ensure   => installed,
      }
      package {'test123':
        ensure   => installed,
      }
    }

    """

  Scenario: Definition from yaml file
    Given a file named "input.yml" with:
    """
    ---
    ssh-server:
      version: 1.2.3
      provider: yum
    ssh-client:
      version: latest
    zsh:
      version: installed
    bash: {}
    """
    When I successfully run `ppgen package --source input.yml --destination file:out.txt --import-filter yaml`
    Then the file "out.txt" should contain:
    """
    class mymodule::myclass {
      package {'ssh-server':
        ensure   => 1.2.3,
        provider => yum,
      }
      package {'ssh-client':
        ensure   => latest,
      }
      package {'zsh':
        ensure   => installed,
      }
      package {'bash':
        ensure   => installed,
      }
    }

    """

  Scenario: Definition from yaml file with error
    Given a file named "input.yml" with:
    """
    ---
    ssh-server:
    version: 1.2.3
    zsh:
      version: installed
    bash: {}
    """
    When I run `ppgen package --source input.yml --destination file:out.txt --import-filter yaml`
    Then the exit status should be 5
    And the stderr should contain "The input is no YAML valid for this use case"
