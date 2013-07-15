module PuppetGenerator
  module Middleware
    class CreateOutputObjectFromEntry

      def initialize(app)
        @app = app
      end

      def call(task)
        @task = task
        converter = Models::EntryConverter.find( resource )

        raise Exceptions::InvalidEntryConverter, "I was not able to find an entry converter for command \"#{ resource }\". Available converters are: #{ Models::EntryConverter.all_names_as_string }" unless converter

        PuppetGenerator.logger.debug(self.class.name){ "Convert entries for resource \"#{ resource }\"" }
        PuppetGenerator.logger.debug(self.class.name){ "Convert entries to output objects using converter \"#{ converter.name }.\"" }


        task.body = converter.convert( task.body )

        @app.call(task)
      end

      def resource
        @task.meta[ :command_chain ].last
      end
    end
  end
end
