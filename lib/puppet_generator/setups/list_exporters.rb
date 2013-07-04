module PuppetGenerator
  module Setups
    class ListExporters < Base

      def description
        "List all available exporters"
      end

      def environment
        use_defaults_for :error_message
        enable_all_of :exporter
      end

    end
  end
end
