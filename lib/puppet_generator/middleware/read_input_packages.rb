module PuppetGenerator
  module Middleware
    class ReadInput

      include ReadInputHelper

      def initialize(app)
        @app = app
      end

      def call(task)
        importer = PuppetGenerator::Models::Importer.find( reads_from: task.meta[:source], enabled: true )
        raise PuppetGenerator::Exceptions::InvalidSource unless importer 

        PuppetGenerator.logger.debug(self.class.name){ "Read data from input \"#{task.meta[:source]}\" using importer \"#{importer.class.name}\"." }

        task.body = importer.read( task.meta[:source] )

        PuppetGenerator.logger.debug(self.class.name) { "Count input lines: #{task.body.size}" }

        @app.call(task)
      end
    end
  end
end
