module PuppetGenerator
  module Ui
    class Tasks < Thor
      def self.exit_on_failure?
        true
      end

      class_option :source, Ui::CommandlineParserHelper.subcommand_options[:source] 
      class_option :destination, Ui::CommandlineParserHelper.subcommand_options[:destination]
      desc "create_roles_in_directory", "Search directory for directories and generate role puppet definition for found .pp-files"
      def create_roles_in_directory
        PuppetGenerator::Ui::Runner.start( %W[create role --export-filter build_role_includes_for_directory --source #{options[:source]} --destination #{options[:destination]}] )
      end
    end
  end
end
