module PuppetGenerator
  module Api
    class ListActions < Base

      include Hirb::Console

      def list(filter)
        list_actions_package if filter.include? :package
        list_actions_user if filter.include? :user
        list_actions_file if filter.include? :file
        list_actions_all if filter.include? :all

        table Models::Action.find_all(enabled: true).sort, style: :unicode, fields: [ :name ]
      end

      private

      def list_actions_all
        generate_data Setup::AllActions, "Generating list of all available actions." 
      end

      def list_actions_user
        generate_data Setup::User, "Generating list of actions for type \"user\"." 
      end

      def list_actions_package
        generate_data Setup::Package, "Generating list of actions for type \"package\"." 
      end

      def list_actions_file
        generate_data Setup::File, "Generating list of actions for type \"file\"." 
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
