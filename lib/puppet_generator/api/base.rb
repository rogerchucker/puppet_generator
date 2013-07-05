module PuppetGenerator
  module Api
    class Base

      def initialize(options)
        @options = options
      end

      private

      attr_reader :options

      def class_name
        self.class.name.underscore
      end

      def description
        raise Exceptions::MethodNeedsToBeImplemented, "You need to implement a \"description\"-method to make the api subclass work."
      end

      def generate_data
        debugger
        task = Task.new( options )
        pre_stack.call(task)

        active_setup = Models::Setup.find( task.meta[:command_chain].join("_") )

        run_with_messages startup_message: active_setup.description do
          default_stack.call(task)
        end
      end
      alias_method :run, :generate_data

      def pre_stack
        ::Middleware::Builder.new do
          use PuppetGenerator::Middleware::SetupEnvironment
          use PuppetGenerator::Middleware::EnableDebuggingLibraries
          use PuppetGenerator::Middleware::ConfigureLogging
        end
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
