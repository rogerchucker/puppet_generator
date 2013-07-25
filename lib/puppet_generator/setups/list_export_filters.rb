module PuppetGenerator
  module Setups
    class ListExportFilters < Base

      def description
        "List all available export filters"
      end

      def environment
        use_defaults_for :error_message
        enable_all_of :export_filter
      end

    end
  end
end
