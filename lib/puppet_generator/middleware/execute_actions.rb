module PuppetGenerator
  module Middleware
    class ExecuteActions

      def initialize(app)
        @app = app
      end

      def call(task)
        PuppetGenerator.logger.debug(self.class.name){ "Execute action \"#{task.meta[:requested_actions].join(", ")}\" on output." }

        execute_actions( task.meta[:requested_actions] , task )

        @app.call(task)
      end

      private

      def execute_actions(actions, task)

        module_name = task.meta[:module]
        objects = task.body

        actions.inject(objects) do |objects,action|
          active_action = Models::Action.find action
          raise Exceptions::UnknownAction unless active_action

          active_action.run( objects, task )
        end
      end

    end
  end
end
