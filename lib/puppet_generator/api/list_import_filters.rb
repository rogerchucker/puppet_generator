module PuppetGenerator
  module Api
    class ListImportFilters < Base

      include Hirb::Console

      def list(filter)
        list_import_filters_package if filter.include? :package
        list_import_filters_user if filter.include? :user
        list_import_filters_file if filter.include? :file
        list_import_filters_all if filter.include? :all

        table Models::ImportFilter.find_all(enabled: true).sort, style: :unicode, fields: [ :name ]
      end

      private

      def list_import_filters_all
        generate_data Setup::AllImportFilters, "Generating list of all available import_filters." 
      end

      def list_import_filters_user
        generate_data Setup::User, "Generating list of import_filters for type \"user\"." 
      end

      def list_import_filters_package
        generate_data Setup::Package, "Generating list of import_filters for type \"package\"." 
      end

      def list_import_filters_file
        generate_data Setup::File, "Generating list of import_filters for type \"file\"." 
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
