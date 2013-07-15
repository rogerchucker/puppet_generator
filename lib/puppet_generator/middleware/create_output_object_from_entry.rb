module PuppetGenerator
  module Middleware
    class CreateOutputObjectFromEntry

      def initialize(app)
        @app = app
      end

      def call(task)
        converter = Models::EntryConverter.find( task.meta[ :command_chain ].last )

        raise Exceptions::InvalidEntryConverter, "I was not able to find an entry converter for command \"#{ task.meta[ :resource ] }\". Available converters are: #{ Models::EntryConverter.all_names_as_string }" unless converter

        PuppetGenerator.logger.debug(self.class.name){ "Convert entries for resource \"#{ task.meta[:resource] }\"" }
        PuppetGenerator.logger.debug(self.class.name){ "Convert entries to output objects using converter \"#{ converter.name }.\"" }


        task.body = converter.convert( task.body )

        @app.call(task)
      end
    end
  end
end
