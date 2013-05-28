module PuppetGenerator
  class InputFilter
    def initialize(app)
      @app = app
    end

    def call(task)
      task.logger.debug("filter input")

      @app.call(task)
    end
  end
end
