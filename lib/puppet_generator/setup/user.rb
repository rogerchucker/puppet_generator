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

        Models::ImportFilter.enable :passwd
        Models::Template.find_all(:user).collect { |t| t.enable }

      end
    end
  end
end
