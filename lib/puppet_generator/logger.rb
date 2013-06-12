class ::Logger
  SILENT = 9999 unless defined? SILENT
end

module PuppetGenerator
  class Logger

    extend ::Forwardable
    def_delegators :@logger, :fatal, :warn, :debug, :info, :error, :unknown

    attr_reader :mode

    def initialize
      @logger = ::Logger.new($stderr)
      self.mode = :info
    end

    def mode=(m)
      @mode = m

      case m
      when :debug
        @logger.level = ::Logger::DEBUG
        format_debug
      when :silent
        @logger.level = ::Logger::SILENT
      when :info
        @logger.level = ::Logger::INFO
        format_standard
      else
        @logger.level = ::Logger::INFO
        format_standard
      end
    end

    private

    def format_debug
      @logger.formatter = proc { |severity, datetime, progname , msg|
                                 debug_msg("%s %s %s: %s\n" % [ datetime, severity, progname, msg ])
      }
    end

    def format_standard
      @logger.formatter = proc { |severity, datetime, _, msg|
        info_msg( "%s %s: %s\n" % [ datetime, severity, msg ] )
      }
    end

    def error_msg(msg)
      ANSI.red(msg)
    end

    def info_msg(msg)
      msg
    end

    def debug_msg(msg)
      msg
    end
  end
end
