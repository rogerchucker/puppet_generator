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
      begin
        @app.call(task)
      rescue PuppetGenerator::Exceptions::InvalidSource
        error 1, "You entered an invalid source: it's not a directory or a file or you tell me to use a file/directory which does not exist."
      rescue PuppetGenerator::Exceptions::InvalidOutputChannel
        error 2, "You entered an invalid output channel: file or directory can be used."
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
