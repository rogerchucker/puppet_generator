module PuppetGenerator
  module Setups
    class CreateFile < Base

      def description
        'Create files and directories'
      end

      def environment
        use_defaults_for :error_message, :import_filter, :action, :importer, :export_filter

        enable_importer :directory
        enable_export_filter :filesystem_attributes, :copy_files_to_module_directory, :puppet_meta_information
      end
    end
  end
end
