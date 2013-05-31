module PuppetGenerator
  module Middleware
    class EntryToPackage
      def initialize(app)
        @app = app
      end

      def call(task)
        PuppetGenerator.logger.debug(self.class.name){ "Convert entries to puppet package objects." }
        task.body = task.body.collect { |e| PuppetPackage.new( e, task.meta[:module] , task.meta[:class] ) }

        @app.call(task)
      end
    end
  end
end
