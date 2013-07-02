module PuppetGenerator
  module Setups
    class ListImporters < Bare

      def description
        "List all available importers" 
      end

      def environment
        use_defaults_for :error_message
        enable_all_of :importer
      end

    end
  end
end
