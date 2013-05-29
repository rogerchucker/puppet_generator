module PuppetGenerator
  module Middleware
    class ExecuteActions

      def initialize(app)
        @app = app
      end

      def call(task)
        task.logger.debug(self.class.name){ "filter the input with filter \"#{task.meta[:requested_action]}\"" }

        begin
          active_action = task.meta[:actions].fetch( task.meta[:requested_action].to_sym )
        rescue
          raise Exceptions::UnknownAction unless active_action
        end

        active_action.run( task )

        @app.call(task)
      end

    end
  end
end
