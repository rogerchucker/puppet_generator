module PuppetGenerator
  module Api
    class ListImporters < Base

      include Hirb::Console

      def list(filter)
        list_importers_package if filter.include? :package
        list_importers_user if filter.include? :user
        list_importers_file if filter.include? :file
        list_importers_all if filter.include? :all

        table Models::Importer.find_all(enabled: true).sort, style: :unicode, fields: [ :name ]
      end

      private

      def list_importers_all
        generate_data Setup::AllImporters, "Generating list of all available importers." 
      end

      def list_importers_user
        generate_data Setup::User, "Generating list of importers for type \"user\"." 
      end

      def list_importers_package
        generate_data Setup::Package, "Generating list of importers for type \"package\"." 
      end

      def list_importers_file
        generate_data Setup::File, "Generating list of importers for type \"file\"." 
      end

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
