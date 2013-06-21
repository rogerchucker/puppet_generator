module PuppetGenerator
  module Ui
    class List < Thor
      extend ThorHelper

      desc "actions", "List available actions for given filter"
      method_option :filter, Ui::CommandlineParserHelper.subcommand_options[:list_filter]
      def actions
        PuppetGenerator::Api::ListActions.new(options).list(options[:filter].map(&:to_sym))
      end

      desc "exporters", "List available exporters"
      def exporters
        PuppetGenerator::Api::ListExporters.new(options).list
      end

      desc "importers", "List available importers for given filter"
      method_option :filter, Ui::CommandlineParserHelper.subcommand_options[:list_filter]
      def importers
        PuppetGenerator::Api::ListImporters.new(options).list(options[:filter].map(&:to_sym))
      end
    end
  end
end
