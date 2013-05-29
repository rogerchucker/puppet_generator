module PuppetGenerator
  module Middleware
    class HandleErrors
      def initialize(app)
        @app = app
      end

      def call(t)
        @task = t

        task.logger.debug(self.class.name){ "waiting for errors" }


        begin
          @app.call(task)
        rescue PuppetGenerator::Exceptions::InvalidSource
          exit_with_error 1
        rescue PuppetGenerator::Exceptions::InvalidOutputChannel
          exit_with_error 2
        rescue PuppetGenerator::Exceptions::EmptySource
          exit_with_error 3
        rescue PuppetGenerator::Exceptions::UnknownImportFilter
          exit_with_error 4
        rescue PuppetGenerator::Exceptions::InvalidYamlInput
          exit_with_error 5
        rescue PuppetGenerator::Exceptions::InvalidPasswdInput
          exit_with_error 6
        rescue PuppetGenerator::Exceptions::UnknownAction
          exit_with_error 7
        end
      end

      private 

      attr_reader :task

      def exit_with_error(code)
        task.logger.fatal Models::ErrorMessage.find(code).text
        exit code
      end

      def postscript
      end

      def option_to_output(option)
        option.keys.join(", ")
      end
    end
  end
end
