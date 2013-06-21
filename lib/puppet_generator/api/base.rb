module PuppetGenerator
  class Api
    class Base

      def initialize(options)
        @options = options
      end

      private

      attr_reader :options

      def pre_stack
        ::Middleware::Builder.new do
          use PuppetGenerator::Middleware::EnableDebuggingLibraries
          use PuppetGenerator::Middleware::ConfigureLogging
        end
      end

      def setup(klass)
        s = klass.new(options)
        s.setup_environment

        s.create_task
      end

      def run_with_messages(opts, &block)
        options = {
          startup_message: "Operation successfully started.",
          teardown_message: "Operation successfully ended." 
        }.merge opts

        PuppetGenerator.logger.info(self.class.name) { options[:startup_message] }
        block.call
        PuppetGenerator.logger.info(self.class.name) { options[:teardown_message] }
      end
    end
  end
end
