module PuppetGenerator
  class CheckForEmptySource
    def initialize(app)
      @app = app
    end

    def call(task)
      task.logger.debug("checking for empty sources")
      raise PuppetGenerator::Exceptions::EmptySource if task.body.entries.empty?

      @app.call(task)
    end
  end
end
