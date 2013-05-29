module PuppetGenerator
  module Middleware
    class ExecuteActions

      def initialize(app)
        @app = app
      end

      def call(task)
        task.logger.debug(self.class.name){ "filter the input with filter \"#{task.meta[:requested_action]}\"" }

        begin
          active_action = Models::Action.find task.meta[:requested_action]
        rescue
          raise Exceptions::UnknownAction unless active_action
        end

        task.body = active_action.run( task )

        @app.call(task)
      end

    end
  end
end
