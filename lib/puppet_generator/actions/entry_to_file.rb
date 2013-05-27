module PuppetGenerator
  class EntryToFile
    def initialize(app)
      @app = app
    end

    def call(task)
      task.body[:files] = task.body[:input].entries.collect { |e| PuppetFile.new( e, task.meta[:module] , task.meta[:class] )}

      @app.call(task)
    end
  end
end
