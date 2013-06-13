module PuppetGenerator
  module Ui
    class Runner < Thor
      def self.exit_on_failure?
        true
      end

      class_option :module, Ui::CommandlineParserHelper.runner_options[:module]
      class_option :class, Ui::CommandlineParserHelper.runner_options[:class]
      class_option :debug, Ui::CommandlineParserHelper.runner_options[:debug]
      class_option :silent, Ui::CommandlineParserHelper.runner_options[:silent]

      desc "create <type>", "Create puppet dsl. Available types: #{Ui::CommandlineParserHelper.pretty_subcommands(Create.tasks)}"
      subcommand :create, Create

#      desc "list <resource>", "List instances for a given resource. Available resources are: #{Ui::CommandlineParserHelper.pretty_subcommands(List.tasks)}"
#      subcommand :list, List

      desc "tasks <task>", "Run command with predefined options. Available tasks: #{Ui::CommandlineParserHelper.pretty_subcommands(Tasks.tasks)}"
      subcommand :tasks, Tasks
    end
  end
end
