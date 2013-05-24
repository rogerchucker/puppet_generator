module PuppetGenerator
  class HandleErrors
    def initialize(app)
      @app = app
      @logger = Logger.new($stdout)
    end

    def call(task)
      begin
        @app.call(task)
      rescue PuppetGenerator::Exceptions::InvalidSource
        error 1, "You entered an invalid source: it's not a directory or a file or you tell me to use a file/directory which does not exist."
      end
    end

    private 

    def error(exitcode, message)
      @logger.fatal message
      exit exitcode
    end
  end
end
