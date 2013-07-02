module PuppetGenerator
  module Setups
    class ShowVersion < Bare
      
      def description
        "Setup up to show version" 
      end

      def environment
        use_defaults_for :error_message, :import_filter, :action, :importer, :export_filter
        enable_template_for :show_version
      end

    end
  end
end

