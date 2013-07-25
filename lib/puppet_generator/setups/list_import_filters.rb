module PuppetGenerator
  module Setups
    class ListImportFilters < Base

      def description
        "List all available import filters"
      end

      def environment
        use_defaults_for :error_message
        enable_all_of :import_filter
      end

    end
  end
end
