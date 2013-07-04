module PuppetGenerator
  module Setups
    class ListImportFilters < Base

      def description
        "List all available import filers"
      end

      def environment
        use_defaults_for :error_message
        enable_all_of :importer
      end

    end
  end
end
