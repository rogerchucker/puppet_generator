module PuppetGenerator
  module Setup
    class User < Bare
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

        Models::ImportFilter.enable :passwd
        Models::Template.find_all(:user).collect { |t| t.enable }
      end

      def create_task
        Task.new(
          HashWithIndifferentAccess.new( { command: :user } ).merge @options
        )
      end
    end
  end
end
