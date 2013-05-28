module PuppetGenerator
  class EntryToFile
    def initialize(app)
      @app = app
    end

    def call(task)
      task.logger.debug("convert entries to puppet file objects")
      task.body[:output] = task.body[:input].entries.collect { |e| PuppetFile.new( e, task.meta[:module] , task.meta[:class] ) }

      @app.call(task)
    end
  end
end
