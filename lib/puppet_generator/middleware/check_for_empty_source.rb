module PuppetGenerator
  module Middleware
    class CheckForEmptySource
      def initialize(app)
        @app = app
      end

      def call(task)
        task.logger.debug(self.class.name){ "checking for empty sources" }
        raise PuppetGenerator::Exceptions::EmptySource if task.body.empty?

        @app.call(task)
      end
    end
  end
end
