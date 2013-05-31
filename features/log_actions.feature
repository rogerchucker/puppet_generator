Feature: Logging

  As a software developer
  I need more feedback during development
  In order to get those things up and running

  Scenario: Plain Input File with verbose information
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen file --debug`
    Then the stderr should contain:
    """
    Logging is configured with mode "debug".
    """
    Then the stderr should contain:
    """
    Available templates: class, single
    """
    Then the stderr should contain:
    """
    Available filter: null, yaml, filesystem_attributes
    """
    Then the stderr should contain:
    """
    Available actions: null, copy_files_to_module
    """
    Then the stderr should contain:
    """
    Waiting for errors to occure. ;-)
    """
    Then the stderr should contain:
    """
    Read data from input "input.txt".
    """
    Then the stderr should contain:
    """
    Count input lines: 1
    """
    Then the stderr should contain:
    """
    Checking if given source "input.txt" is empty.
    """
    Then the stderr should contain:
    """
    Filter the input with filter "null"
    """
    Then the stderr should contain:
    """
    Execute action "null" on output.
    """
    Then the stderr should contain:
    """
    Convert entries to puppet file objects.
    """
    Then the stderr should contain:
    """
    Render template for channel "dir" and sink "out.d".
    """

  Scenario: Silent action
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen file --silent`
    Then the output should contain:
    """
    """

  Scenario: Normal action
    Given a file named "input.txt" with:
    """
    asdf
    """
    When I successfully run `ppgen file`
    Then the output should contain:
    """
    """
