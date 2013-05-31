module PuppetGenerator
  module Middleware
    class ConfigureLogging
      def initialize(app)
        @app = app
      end

      def call(task)
        task.logger = PuppetGenerator::Logger.new

        case task.meta[:mode]
        when :debug
          task.logger.mode = :debug
        when :silent
          task.logger.mode = :silent
        else
          task.logger.mode = :info
        end

        task.logger.debug(self.class.name){ "Logging is configured with mode \"#{task.meta[:mode]}\"." }

        @app.call(task)
      end

      private

      def bold_red(msg)
        ANSI.bold(ANSI.red(msg))
      end
    end
  end
end
