module PuppetGenerator
  class HandleErrors
    def initialize(app)
      @app = app

      @logger = Logger.new($stderr)
      @logger.formatter = proc { |severity, _, _, msg|
        "%s: %s\n" % [ bold_red(severity), msg.dump ]
      }
    end

    def call(task)
      task.logger.debug("waiting for errors")
      begin
        @app.call(task)
      rescue PuppetGenerator::Exceptions::InvalidSource
        error 1, "You entered an invalid source: it's not a directory or a file or you tell me to use a file/directory which does not exist or is empty."
      rescue PuppetGenerator::Exceptions::InvalidOutputChannel
        error 2, "You entered an invalid output channel: file or directory can be used."
      rescue PuppetGenerator::Exceptions::EmptySource
        error 3, "Sorry, but I can't fullfill your request. The source you tell me to use does not contain any entries. Giving up."
      end
    end

    private 

    def error(exitcode, message)
      @logger.fatal message
      exit exitcode
    end

    def bold_red(msg)
      ANSI.bold(ANSI.red(msg))
    end

  end
end
