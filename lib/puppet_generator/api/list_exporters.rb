module PuppetGenerator
  module Api
    class ListExporters < Base

      include Hirb::Console

      def list
        generate_data Setup::AllExporters, "Generating list of all available exporters." 
        table Models::Exporter.find_all(enabled: true), style: :unicode, fields: [ :name ]
      end

      private

      def default_stack
        ::Middleware::Builder.new do
          use PuppetGenerator::Middleware::OutputDebugInformationForModels
          use PuppetGenerator::Middleware::HandleErrors
#          use PuppetGenerator::Middleware::CreateList
#          use PuppetGenerator::Middleware::CreateOutput
        end
      end

    end
  end
end
