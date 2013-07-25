module PuppetGenerator
  module Setups
    class CreatePackage < Base
      def description
        "Create package"
      end

      def environment
        use_defaults_for :error_message, :import_filter, :action, :importer, :export_filter
        enable_all_of :action
        enable_export_filter :puppet_meta_information
      end

    end
  end
end
