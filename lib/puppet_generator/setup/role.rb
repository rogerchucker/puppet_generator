module PuppetGenerator
  module Setup
    class Role < Bare

      def initialize(options)
        super
        @task = Task.new(options)
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
    end
  end
end
