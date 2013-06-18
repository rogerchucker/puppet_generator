module PuppetGenerator
  module Ui
    class List < Thor
      def self.exit_on_failure?
        true
      end

      desc "actions", "List available actions for given filter"
      method_option :filter, Ui::CommandlineParserHelper.subcommand_options[:list_filter]
      def actions
      end
    end
  end
end
