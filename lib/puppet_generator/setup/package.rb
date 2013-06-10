module PuppetGenerator
  module Setup
    class Package < Bare


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

        Models::Template.find_all(:package).collect { |t| t.enable }
      end
    end
  end
end
