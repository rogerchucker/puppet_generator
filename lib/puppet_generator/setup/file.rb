module PuppetGenerator
  module Setup
    class File < Bare

      def initialize(options)
        super
      end

      def setup_environment
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

      def create_task
        Task.new(
          HashWithIndifferentAccess.new( { command: :file } ).merge @options
        )
      end
    end
  end
end
