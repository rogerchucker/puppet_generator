module PuppetGenerator
  module Middleware
    class HandleErrors
      def initialize(app)
        @app = app
      end

      def call(task)
        @logger = task.logger

        @logger.debug(self.class.name){ "waiting for errors" }

        begin
          @app.call(task)
        rescue PuppetGenerator::Exceptions::InvalidSource
          error 1, "#{preamble}You entered an invalid source \"#{task.meta[:source]}\": it's not a directory or a file or you tell me to use a file/directory which does not exist or is empty. #{postscript}"
        rescue PuppetGenerator::Exceptions::InvalidOutputChannel
          error 2, "#{preamble}You entered an invalid output channel: file or directory can be used.#{postscript}"
        rescue PuppetGenerator::Exceptions::EmptySource
          error 3, "#{preamble}The source \"#{task.meta[:source]}\" you tell me to use does not contain any entries. Giving up.#{postscript}"
        rescue PuppetGenerator::Exceptions::UnknownImportFilter
          error 4, "#{preamble}There's no import filter \"#{task.meta[:requested_import_filter]}\". Available import filters: #{option_to_output(task.meta[:import_filter])}.#{postscript}"
        rescue PuppetGenerator::Exceptions::InvalidYamlInput
          error 5, "#{preamble}The input is no YAML valid for this use case.#{postscript}"
        rescue PuppetGenerator::Exceptions::InvalidPasswdInput
          error 6, "#{preamble}The input is no passwd file valid for this use case.#{postscript}"
        end
      end

      private 

      def preamble
        "Sorry, but I can't fullfill your request. "
      end

      def postscript
        "\n\n=================\nPlease read the manual on \"http://github.com/maxmeyer/puppet_generator\" for more information on how to use the script."
      end

      def error(exitcode, message)
        @logger.fatal message
        exit exitcode
      end

      def option_to_output(option)
        option.keys.join(", ")
      end
    end
  end
end
