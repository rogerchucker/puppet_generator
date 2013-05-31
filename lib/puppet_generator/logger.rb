class ::Logger
  SILENT = 9999
end

module PuppetGenerator
  class Logger

    extend Forwardable
    def_delegators :@logger, :fatal, :warn, :debug, :info, :error, :unknown

    attr_reader :mode

    def initialize
      @logger = ::Logger.new($stderr)
    end

    def mode=(m)
      @mode = m

      case m
      when :debug
        @logger.level = ::Logger::DEBUG
        @logger.formatter = proc { |severity, datetime, progname , msg|
                                   "%s %s %s: %s\n" % [ datetime, severity, progname, msg ]
        }
      when :silent
        @logger.level = ::Logger::SILENT
      else
        @logger.level = ::Logger::WARN
        @logger.formatter = proc { |severity, _, _, msg|
          "%s: %s\n\n" % [ bold_red(severity), msg ]
        }
      end
    end

    private

    def bold_red(msg)
      ANSI.bold(ANSI.red(msg))
    end
  end
end
