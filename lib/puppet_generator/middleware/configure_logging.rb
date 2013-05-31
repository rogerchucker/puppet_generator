module PuppetGenerator
  module Middleware
    class ConfigureLogging
      def initialize(app)
        @app = app
      end

      def call(task)
        task.logger = PuppetGenerator::Logger.new
        task.logger.mode = :debug

        task.logger.debug(self.class.name){ "configure logging" }

        @app.call(task)
      end

      private

      def bold_red(msg)
        ANSI.bold(ANSI.red(msg))
      end
    end
  end
end
