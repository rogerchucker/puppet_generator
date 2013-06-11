module PuppetGenerator
  module Setup
    class Module < Bare


      def initialize(options)
        super
      end

      def setup_environment
        DefaultErrorMessages.use
      end

      def create_task
        Task.new(
          HashWithIndifferentAccess.new( { command: :module } ).merge @options
        )
      end

    end
  end
end
