module PuppetGenerator
  class EntryToPackage
    def initialize(app)
      @app = app
    end

    def call(task)
      task.body[:output] = task.body[:input].entries.collect { |e| PuppetPackage.new( e, task.meta[:module] , task.meta[:class] )}

      @app.call(task)
    end
  end
end
