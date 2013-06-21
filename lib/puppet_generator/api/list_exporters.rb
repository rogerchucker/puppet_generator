module PuppetGenerator
  module Api
    class ListExporters < Base

      include Hirb::Console

      def list(filter)
        list_exporters_package if filter.include? :package
        list_exporters_user if filter.include? :user
        list_exporters_file if filter.include? :file
        list_exporters_all if filter.include? :all

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

      def list_exporters_all
        generate_list Setup::AllExporters, "Generating list of all available exporters." 
      end

      def list_exporters_user
        generate_list Setup::User, "Generating list of exporters for type \"user\"." 
      end

      def list_exporters_package
        generate_list Setup::Package, "Generating list of exporters for type \"package\"." 
      end

      def list_exporters_file
        generate_list Setup::File, "Generating list of exporters for type \"file\"." 
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
