module PuppetGenerator
  class EntryToUser
    def initialize(app)
      @app = app
    end

    def call(task)
      task.logger.debug("convert entries to puppet user objects")
      task.body = task.body.entries.collect { |e| PuppetUser.new( e, task.meta[:module] , task.meta[:class] ) }

      @app.call(task)
    end
  end
end
