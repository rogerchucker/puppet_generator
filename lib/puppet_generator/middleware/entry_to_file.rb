module PuppetGenerator
  module Middleware
    class EntryToFile
      def initialize(app)
        @app = app
      end

      def call(task)
        PuppetGenerator.logger.debug(self.class.name){ "Convert entries to puppet file objects." }
        task.body = task.body.collect { |e| PuppetFile.new( e, task.meta[:module] , task.meta[:class] ) }

        @app.call(task)
      end
    end
  end
end
