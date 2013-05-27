module PuppetGenerator
  class CheckForEmptySource
    def initialize(app)
      @app = app
    end

    def call(task)
      raise PuppetGenerator::Exceptions::EmptySource if task.body[:input].entries.empty?
    end
  end
end
