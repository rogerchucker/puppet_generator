module PuppetGenerator
  class Api
    class Create

      def initialize(options)
        @options = options
      end

      def package_definition
        generate_definition Setup::Package, "Generating puppet definitions for type \"package\"." 
      end

      def file_definition
        generate_definition Setup::File, "Generating puppet definitions for type \"file\"." 
      end

      def user_definition
        generate_definition Setup::User, "Generating puppet definitions for type \"user\"." 
      end

      def role_definition
        generate_definition Setup::Role, "Generating puppet definitions for type \"role\"." 
      end

      private

      attr_reader :options

      def setup(klass)
        s = klass.new(options)
        s.setup_environment

        s.create_task
      end

      def generate_definition(setup_klass, startup_message)
        task = setup setup_klass
        pre_stack.call(task)

        run_with_messages startup_message: startup_message do
          default_stack.call(task)
        end
      end

      def default_stack
        ::Middleware::Builder.new do
          use PuppetGenerator::Middleware::OutputDebugInformationForModels
          use PuppetGenerator::Middleware::HandleErrors
          use PuppetGenerator::Middleware::ReadInput
          use PuppetGenerator::Middleware::CheckForEmptySource
          use PuppetGenerator::Middleware::FilterImportedData
          use PuppetGenerator::Middleware::ApplyExportFilters
          use PuppetGenerator::Middleware::ExecuteActions
          use PuppetGenerator::Middleware::CreatePuppetObjectFromEntry
          use PuppetGenerator::Middleware::CreateOutput
        end
      end

      def pre_stack
        ::Middleware::Builder.new do
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
