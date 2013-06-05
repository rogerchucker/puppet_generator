module PuppetGenerator
  module Middleware
    class ExecuteActions

      def initialize(app)
        @app = app
      end

      def call(task)
        PuppetGenerator.logger.debug(self.class.name){ "Execute action \"#{task.meta[:requested_action]}\" on output." }

        active_action = Models::Action.find task.meta[:requested_action]
        raise Exceptions::UnknownAction unless active_action

        task.body = active_action.run( task )

        @app.call(task)
      end

    end
  end
end
