#!/usr/bin/env ruby

module PuppetGenerator
  class Runner < Thor
    def self.exit_on_failure?
      true
    end

    desc "create <type>", "Create puppet dsl for <type>"
    subcommand :create, Create

    desc "tasks <task>", "Run command with predefined options"
    subcommand :tasks, Tasks
  end
end
