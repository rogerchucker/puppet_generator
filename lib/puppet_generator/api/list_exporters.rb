module PuppetGenerator
  module Api
    class ListExporters < Base

      include Hirb::Console

      def list
        generate_list Setup::AllExporters, "Generating list of all available exporters." 
        table Models::Exporter.find_all(enabled: true), style: :unicode, fields: [ :name ]
      end

      private

      def generate_list(setup_klass, startup_message)
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
        end
      end

    end
  end
end
