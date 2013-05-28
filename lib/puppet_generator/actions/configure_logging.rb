module PuppetGenerator
  class ConfigureLogging
    def initialize(app)
      @app = app
    end

    def call(task)
      task.logger = Logger.new($stderr)

      if task.meta[:mode] == :debug
        task.logger.level = Logger::DEBUG
      else
        task.logger.level = Logger::WARN
        task.logger.formatter = proc { |severity, _, _, msg|
          "%s: %s\n\n" % [ bold_red(severity), msg ]
        }
      end

      @app.call(task)
    end

    private

    def bold_red(msg)
      ANSI.bold(ANSI.red(msg))
    end
  end
end
