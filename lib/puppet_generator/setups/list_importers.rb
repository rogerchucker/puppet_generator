module PuppetGenerator
  module Setup
    class AllImporters < Bare
      def initialize(options)
        super
        @task = Task.new(options)
      end

      def setup_environment
        DefaultErrorMessages.use
        Models::Importer.all.each { |t| t.enable }
      end

      def create_task
        Task.new(
          HashWithIndifferentAccess.new( { command: :list_actions } ).merge @options
        )
      end
    end
  end
end
