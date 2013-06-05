module PuppetGenerator
  module Setup
    class Module < Bare


      def initialize(options)
        super
        @task = Task.new(options)
      end

      def setup_environment
        DefaultErrorMessages.use
      end

    end
  end
end
