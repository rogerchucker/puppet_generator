module PuppetGenerator
  class EntryToPackage
    def initialize(app)
      @app = app
    end

    def call(task)
      task.body[:packages] = task.body[:input].entries.collect { |e| PuppetPackage.new( e )}
      task.body[:class] = PuppetClass.new( task.meta[:class] , task.meta[:module])

      @app.call(task)
    end
  end
end
