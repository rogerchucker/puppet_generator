module PuppetGenerator
  module Api
    class CreateDefinition < Base

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
