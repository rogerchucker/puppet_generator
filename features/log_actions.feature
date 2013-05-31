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
    PuppetGenerator::Middleware::ConfigureLogging: configure logging
    """
    Then the stderr should contain:
    """
    PuppetGenerator::Middleware::OutputDebugInformationForModels: available templates: class, single
    """
    Then the stderr should contain:
    """
    PuppetGenerator::Middleware::OutputDebugInformationForModels: available filter: plain, yaml, filesystem_attributes
    """
    Then the stderr should contain:
    """
    PuppetGenerator::Middleware::OutputDebugInformationForModels: available actions: none, copy_files_to_module
    """
    Then the stderr should contain:
    """
    PuppetGenerator::Middleware::HandleErrors: waiting for errors
    """
    Then the stderr should contain:
    """
    PuppetGenerator::Middleware::ReadInputFiles: read input for files / directories
    """
    Then the stderr should contain:
    """
    PuppetGenerator::Middleware::ReadInputFiles: count input lines: 1
    """
    Then the stderr should contain:
    """
    PuppetGenerator::Middleware::CheckForEmptySource: checking for empty sources
    """
    Then the stderr should contain:
    """
    PuppetGenerator::Middleware::FilterImportedData: filter the input with filter "plain"
    """
    Then the stderr should contain:
    """
    PuppetGenerator::Middleware::ExecuteActions: filter the input with filter "none"
    """
    Then the stderr should contain:
    """
    PuppetGenerator::Middleware::EntryToFile: convert entries to puppet file objects
    """
    Then the stderr should contain:
    """
    PuppetGenerator::Middleware::CreateOutput: render template for channel "dir" and sink "out.d"
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
