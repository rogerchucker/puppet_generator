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

      def generate_list(setup_klass, startup_message)
        task = setup setup_klass
        pre_stack.call(task)

        run_with_messages startup_message: startup_message do
          default_stack.call(task)
        end
      end

      def list_actions_all
        generate_list Setup::AllActions, "Generating list of all available actions." 
      end

      def list_actions_user
        generate_list Setup::User, "Generating list of actions for type \"user\"." 
      end

      def list_actions_package
        generate_list Setup::Package, "Generating list of actions for type \"package\"." 
      end

      def list_actions_file
        generate_list Setup::File, "Generating list of actions for type \"file\"." 
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
