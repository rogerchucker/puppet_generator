module PuppetGenerator
  module Middleware
    class ReadInput

      def initialize(app)
        @app = app
      end

      def call(task)
        PuppetGenerator.logger.debug(self.class.name){ "Read data from input \"#{task.meta[:source]}\"." }

        raise Exceptions::FilesystemError unless PuppetGenerator::Models::Importer.existing_source?(task.meta[:source].to_s)
        raise Exceptions::InvalidSource   unless PuppetGenerator::Models::Importer.valid_source?(task.meta[:source].to_s)

        importer = PuppetGenerator::Models::Importer.find( reads_from: task.meta[:source].to_s, enabled: true )
        raise PuppetGenerator::Exceptions::InvalidSource unless importer 
        PuppetGenerator.logger.debug(self.class.name){ "Using importer \"#{importer.name}\" to read data." }

        PuppetGenerator.logger.info(self.class.name){ "Reading input from \"#{importer.name}\"." }
        task.body = importer.read( task.meta[:source] )
        PuppetGenerator.logger.debug(self.class.name) { "Count input lines: #{task.body.size}" }

        @app.call(task)
      end

    end
  end
end
