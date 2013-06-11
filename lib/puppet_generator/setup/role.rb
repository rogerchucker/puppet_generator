module PuppetGenerator
  module Setup
    class Role < Bare

      def initialize(options)
        super
      end

      def setup_environment
        DefaultErrorMessages.use
        DefaultImportFilter.use
        DefaultActions.use
        DefaultImporter.use
        DefaultExportFilter.use

        Models::Template.find_all(:role).collect { |t| t.enable }
        Models::Importer.enable :directory
      end

      def create_task
        Task.new(
          HashWithIndifferentAccess.new( { command: :role } ).merge @options
        )
      end
    end
  end
end
