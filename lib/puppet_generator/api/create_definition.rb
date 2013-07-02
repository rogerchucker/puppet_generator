module PuppetGenerator
  module Api
    class CreateDefinition < Base

      def package
        generate_data Setup::Package, "Generating puppet definitions for type \"package\"." 
      end

      def file
        generate_data Setup::File, "Generating puppet definitions for type \"file\"." 
      end

      def user
        generate_data Setup::User, "Generating puppet definitions for type \"user\"." 
      end

      def role
        generate_data Setup::Role, "Generating puppet definitions for type \"role\"." 
      end

      private

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
