module PuppetGenerator
  module Setup
    class Package < Bare


      def initialize(options)
        super
      end

      def setup_environment
        DefaultErrorMessages.use
        DefaultImportFilter.use
        DefaultActions.use
        DefaultImporter.use
        DefaultExportFilter.use

        Models::Template.find_all(:package).collect { |t| t.enable }
      end

      def create_task
        Task.new(
          HashWithIndifferentAccess.new( { command: :package } ).merge @options
        )
      end
    end
  end
end
