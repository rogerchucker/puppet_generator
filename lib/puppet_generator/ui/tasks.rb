module PuppetGenerator
  module Ui
    class Tasks < Thor
      extend ThorHelper

      no_tasks {
        def commandline_options(options, *names)
          names.flatten.inject([]) do |memo,name| 
            unless options[name] == false
              memo << "--#{name}"
              memo << options[name] unless options[name] == true
            end

            memo
          end
        end
      }

      class_option :source, Ui::CommandlineParserHelper.subcommand_options[:source] 
      class_option :destination, Ui::CommandlineParserHelper.subcommand_options[:destination]
      desc "create_roles_in_directory", "Search directory for directories and generate role puppet definition for found .pp-files"
      def create_roles_in_directory
        PuppetGenerator::Ui::Runner.start( %W[create role --export-filter build_role_includes_for_directory] + commandline_options(options, :source, :destination, :module, :debug, :silent) )
      end
    end
  end
end
