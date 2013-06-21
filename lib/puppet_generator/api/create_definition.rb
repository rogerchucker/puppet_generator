module PuppetGenerator
  module Api
    class CreateDefinition < Base

      def package
        generate_definition Setup::Package, "Generating puppet definitions for type \"package\"." 
      end

      def file
        generate_definition Setup::File, "Generating puppet definitions for type \"file\"." 
      end

      def user
        generate_definition Setup::User, "Generating puppet definitions for type \"user\"." 
      end

      def role
        generate_definition Setup::Role, "Generating puppet definitions for type \"role\"." 
      end

      private

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
    end
  end
end
