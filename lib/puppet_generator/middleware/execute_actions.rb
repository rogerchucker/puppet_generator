module PuppetGenerator
  module Middleware
    class ExecuteActions

      def initialize(app)
        @app = app
      end

      def call(task)
        task.logger.debug(self.class.name){ "filter the input with filter \"#{task.meta[:requested_action]}\"" }

        active_action = Models::Action.find task.meta[:requested_action]
        raise Exceptions::UnknownAction unless active_action

        task.body = active_action.run( task )

        @app.call(task)
      end

    end
  end
end
