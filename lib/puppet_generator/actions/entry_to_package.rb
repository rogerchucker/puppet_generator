module PuppetGenerator
  class EntryToPackage
    def initialize(app)
      @app = app
    end

    def call(task)
      task.body[:packages] = task.body[:input].entries.collect { |e| Package.new( e, task.meta[:module] )}

      @app.call(task)
    end
  end
end
