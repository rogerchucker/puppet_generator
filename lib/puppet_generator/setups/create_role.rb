module PuppetGenerator
  module Setups
    class CreateRole < Base

      def description
        "Create role"
      end

      def environment
        use_defaults_for :error_message, :import_filter, :action, :importer, :export_filter
        enable_all_of :action

        enable_import_filter :passwd
        enable_importer :directory
        enable_export_filter :build_role_includes_for_directory
      end

    end
  end
end
