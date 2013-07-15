module PuppetGenerator
  module Api
    class ShowVersion < Base

      def show
        run
      end

      private

      def default_stack
        ::Middleware::Builder.new do
          use PuppetGenerator::Middleware::OutputDebugInformationForModels
          use PuppetGenerator::Middleware::HandleErrors
          use PuppetGenerator::Middleware::GenerateVersion
          use PuppetGenerator::Middleware::CreateOutputObjectFromEntry
          use PuppetGenerator::Middleware::CreateOutput
        end
      end

    end
  end
end
