module PuppetGenerator
  module Middleware
    class CreatePuppetObjectFromEntry

      def initialize(app)
        @app = app
      end

      def call(task)
        c = Models::EntryConverter.find( task.meta[ :command ] )

        PuppetGenerator.logger.debug(self.class.name){ "Convert entries for command \"#{ task.meta[:command] }\"" }
        PuppetGenerator.logger.debug(self.class.name){ "Convert entries to puppet objects using converter \"#{ c.name }.\"" }

        task.body = c.convert( task.body, task.meta[:module] , task.meta[:class] )

        @app.call(task)
      end
    end
  end
end
