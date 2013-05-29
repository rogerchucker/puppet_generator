module PuppetGenerator
  module Middleware
    class HandleErrors
      def initialize(app)
        @app = app
      end

      def call(t)
        @task = t

        task.logger.debug(self.class.name){ "waiting for errors" }

        register_error_message 1, "#{preamble}You entered an invalid source \"#{task.meta[:source]}\": it's not a directory or a file or you tell me to use a file/directory which does not exist or is empty. #{postscript}"
        register_error_message 2, "#{preamble}You entered an invalid output channel: file or directory can be used.#{postscript}"
        register_error_message 3, "#{preamble}The source \"#{task.meta[:source]}\" you tell me to use does not contain any entries. Giving up.#{postscript}"
        register_error_message 4, "#{preamble}There's no import filter \"#{task.meta[:requested_import_filter]}\". Available import filters: #{option_to_output(task.meta[:import_filter])}.#{postscript}"
        register_error_message 5, "#{preamble}The input is no YAML valid for this use case.#{postscript}"
        register_error_message 6, "#{preamble}The input is no passwd file valid for this use case.#{postscript}"
        register_error_message 7, "#{preamble}There's no action \"#{task.meta[:requested_action]}\". Available actions: #{option_to_output(task.meta[:actions])}.#{postscript}"

        begin
          @app.call(task)
        rescue PuppetGenerator::Exceptions::InvalidSource
          use_error_message 1
        rescue PuppetGenerator::Exceptions::InvalidOutputChannel
          use_error_message 2
        rescue PuppetGenerator::Exceptions::EmptySource
          use_error_message 3
        rescue PuppetGenerator::Exceptions::UnknownImportFilter
          use_error_message 4
        rescue PuppetGenerator::Exceptions::InvalidYamlInput
          use_error_message 5
        rescue PuppetGenerator::Exceptions::InvalidPasswdInput
          use_error_message 6
        rescue PuppetGenerator::Exceptions::UnknownAction
          use_error_message 7
        end
      end

      private 

      attr_reader :task

      def register_error_message(code, text)
        task.meta[:error_messages] ||= {}
        task.meta[:error_messages][code.to_s] = text
      end

      def use_error_message(code)
        task.meta[:error_messages] ||= {}
        task.logger.fatal task.meta[:error_messages][code.to_s]
        exit code
      end

      def preamble
        "Sorry, but I can't fullfill your request. "
      end

      def postscript
        "\n\n=================\nPlease read the manual on \"http://github.com/maxmeyer/puppet_generator\" for more information on how to use the script."
      end

      def option_to_output(option)
        option.keys.join(", ")
      end
    end
  end
end
