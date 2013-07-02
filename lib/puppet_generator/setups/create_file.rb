module PuppetGenerator
  module Setups
    class CreateFile < Bare

      def environment
        DefaultErrorMessages.use
        DefaultImportFilter.use
        DefaultActions.use
        DefaultImporter.use
        DefaultExportFilter.use

        Models::Action.enable :copy_files_to_module_directory
        Models::Template.find_all(:file).collect { |t| t.enable }
        Models::ExportFilter.enable :filesystem_attributes
        Models::Importer.enable :directory
      end

      def task(options)
        Task.new( options )
      end
    end
  end
end
