module PuppetGenerator
  module Middleware
    class CreatePuppetObjectFromEntry

      def initialize(app)
        @app = app
      end

      def call(task)
        converter = Models::EntryConverter.find( task.meta[ :command ] )

        raise Exceptions::InvalidEntryConverter, "I was not able to find an entry converter for command \"#{ task.meta[ :command ] }\". Available converters are: #{ Models::EntryConverter.all_names_as_string }" unless converter

        PuppetGenerator.logger.debug(self.class.name){ "Convert entries for command \"#{ task.meta[:command] }\"" }
        PuppetGenerator.logger.debug(self.class.name){ "Convert entries to puppet objects using converter \"#{ converter.name }.\"" }


        task.body = converter.convert( task.body, task.meta[:module] , task.meta[:class] )

        @app.call(task)
      end
    end
  end
end
