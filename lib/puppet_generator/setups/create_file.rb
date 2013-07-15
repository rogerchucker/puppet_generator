module PuppetGenerator
  module Setups
    class CreateFile < Base

      def description
        'Create files and directories'
      end

      def environment
        use_defaults_for :error_message, :import_filter, :action, :importer, :export_filter

        enable_template_for :create_file
        enable_importer :directory
        enable_export_filter :filesystem_attributes, :copy_files_to_module_directory
      end
    end
  end
end
