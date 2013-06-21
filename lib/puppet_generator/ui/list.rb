module PuppetGenerator
  module Ui
    class List < Thor
      extend ThorHelper

      desc "actions", "List available actions for given filter"
      method_option :filter, Ui::CommandlineParserHelper.subcommand_options[:list_filter]
      def actions
        PuppetGenerator::Api::ListActions.new(options).actions(options[:filter].map(&:to_sym))
      end
    end
  end
end
