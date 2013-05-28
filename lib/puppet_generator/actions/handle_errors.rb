module PuppetGenerator
  class HandleErrors
    def initialize(app)
      @app = app
    end

    def call(task)
      @logger = task.logger

      @logger.debug("waiting for errors")

      begin
        @app.call(task)
      rescue PuppetGenerator::Exceptions::InvalidSource
        error 1, "#{preamble}You entered an invalid source '#{task.meta[:source]}': it's not a directory or a file or you tell me to use a file/directory which does not exist or is empty. #{postscript}"
      rescue PuppetGenerator::Exceptions::InvalidOutputChannel
        error 2, "#{preamble}You entered an invalid output channel: file or directory can be used.#{postscript}"
      rescue PuppetGenerator::Exceptions::EmptySource
        error 3, "#{preamble}The source '#{task.meta[:source]}' you tell me to use does not contain any entries. Giving up.#{postscript}"
      rescue PuppetGenerator::Exceptions::UnknownInputFilter
        error 4, "#{preamble}There's no input filter #{task.meta[:requested_input_filter]}.#{postscript}"
      end
    end

    private 

    def preamble
      "Sorry, but I can't fullfill your request. "
    end

    def postscript
      "\n\n=================\nPlease read the manual on 'http://github.com/maxmeyer/puppet_generator' for more information on how to use the script."
    end

    def error(exitcode, message)
      @logger.fatal message
      exit exitcode
    end

  end
end
