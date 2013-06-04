module PuppetGenerator
  module Middleware
    class ReadInputPackages

      include ReadInputHelper

      def initialize(app)
        @app = app
      end

      def call(task)
        PuppetGenerator.logger.debug(self.class.name){ "Read data from input \"#{task.meta[:source]}\"." }

        if is_stdin? task.meta[:source]
          task.body = PuppetGenerator::Importers::StdIn.new.lines
        elsif is_file? task.meta[:source]
          task.body = PuppetGenerator::Importers::File.new( task.meta[:source] ).lines
        else
          raise PuppetGenerator::Exceptions::InvalidSource
        end

        PuppetGenerator.logger.debug(self.class.name) { "Count input lines: #{task.body.size}" }

        @app.call(task)
      end
    end
  end
end
