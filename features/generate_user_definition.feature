Feature: Generate user definitions

  As a administrator 
  I need to write users definitions for puppet
  In order to get those things up and running via puppet

  Scenario: Existing Input File
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen user`
    Then the file "out.d/asdf.pp" should contain:
    """
    class mymodule::asdf {
      user {'asdf':
        ensure     => present,
      }
    }

    """

  Scenario: Non Existing Input File
    When I run `ppgen user`
    Then the exit status should be 1
    And the stderr should contain "You entered an invalid source"

  Scenario: Input via Stdin
    When I run `ppgen user --source stdin` interactively
    And I type "asdf"
    And I close the stdin stream
    Then the file "out.d/asdf.pp" should contain:
    """
    class mymodule::asdf {
      user {'asdf':
        ensure     => present,
      }
    }

    """

  Scenario: Multiple lines in input file
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen user`
    Then the file "out.d/asdf.pp" should contain:
    """
    class mymodule::asdf {
      user {'asdf':
        ensure     => present,
      }
    }

    """
    And the file "out.d/test123.pp" should contain:
    """
    class mymodule::test123 {
      user {'test123':
        ensure     => present,
      }
    }

    """

  Scenario: Module name given
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen user --module string1::string2`
    Then the file "out.d/asdf.pp" should contain:
    """
    class string1::string2::asdf {
      user {'asdf':
        ensure     => present,
      }
    }

    """

  Scenario: Multiple lines in input file with one output file
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen user --destination file:out.txt`
    Then the file "out.txt" should contain:
    """
    class mymodule::myclass {
      user {'asdf':
        ensure     => present,
      }
      user {'test123':
        ensure     => present,
      }
    }

    """

  Scenario: Output to stdout
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen user --destination stdout`
    Then the output should contain:
    """
    class mymodule::asdf {
      user {'asdf':
        ensure     => present,
      }
    }

    """

  Scenario: Multiple lines in input file with one output file and one module definition
    Given a file named "input.txt" with:
    """
    asdf
    test123
    """
    When I successfully run `ppgen user --destination file:out.txt --class test`
    Then the file "out.txt" should contain:
    """
    class mymodule::test {
      user {'asdf':
        ensure     => present,
      }
      user {'test123':
        ensure     => present,
      }
    }

    """

    @wip
  Scenario: Using passwd
    Given a file named "etc_passwd" with:
    """
    root:x:0:0:root:/root:/bin/bash
    mail:x:8:12:mail:/var/spool/mail:/bin/false
    """
    When I successfully run `ppgen user --source etc_passwd --destination file:out.txt --import-filter passwd`
    Then the file "out.txt" should contain:
    """
    class mymodule::myclass {
      user {'root':
        ensure     => present,
        uid        => '0',
        gid        => '0',
        homedir    => '/root',
        shell      => '/bin/bash',
      }
      user {'mail':
        ensure     => present,
        uid        => '8',
        gid        => '12',
        homedir    => '/var/spool/mail',
        shell      => '/bin/false',
      }
    }

    """
