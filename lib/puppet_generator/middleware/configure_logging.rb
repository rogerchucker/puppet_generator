module PuppetGenerator
  module Middleware
    class ConfigureLogging
      def initialize(app)
        @app = app
      end

      def call(task)
        case task.meta[:mode]
        when :debug
          PuppetGenerator.logger.mode = :debug
        when :silent
          PuppetGenerator.logger.mode = :silent
        else
          PuppetGenerator.logger.mode = :info
        end

        PuppetGenerator.logger.debug(self.class.name){ "Logging is configured with mode \"#{PuppetGenerator.logger.mode}\"." }

        @app.call(task)
      end

      private

      def bold_red(msg)
        ANSI.bold(ANSI.red(msg))
      end
    end
  end
end
