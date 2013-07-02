module PuppetGenerator
  module Setup
    class AllExporters < Bare
      def initialize(options)
        super
        @task = Task.new(options)
      end

      def setup_environment
        DefaultErrorMessages.use
        Models::Exporter.all.each { |t| t.enable }
      end

      def create_task
        Task.new(
          HashWithIndifferentAccess.new( { command: :list_actions } ).merge @options
        )
      end
    end
  end
end
