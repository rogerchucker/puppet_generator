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
          debug_msg("%s %s %s: %s\n" % [ datetime, severity, progname, msg ])
        }
      when :silent
        @logger.level = ::Logger::SILENT
      else
        @logger.level = ::Logger::INFO
        @logger.formatter = proc { |severity, datetime, _, msg|
          info_msg( "%s %s: %s\n" % [ datetime, severity, msg ] )
        }
      end
    end

    private

    def error_msg(msg)
      ANSI.red(msg)
    end

    def info_msg(msg)
      ANSI.green(msg)
    end

    def debug_msg(msg)
      ANSI.white(msg)
    end
  end
end
