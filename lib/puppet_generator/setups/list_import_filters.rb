module PuppetGenerator
  module Setups
    class ListImportFilters < Bare

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
