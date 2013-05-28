module PuppetGenerator
  module Middleware
    class ReadInputFiles

      include ReadInputHelper

      def initialize(app)
        @app = app
      end

      def call(task)
        task.logger.debug(self.class.name){ "read input for files / directories" }

        if is_directory? task.meta[:source]
          task.body = PuppetGenerator::InputDirectory.new( task.meta[:source] ).lines
        elsif is_stdin? task.meta[:source]
          task.body = PuppetGenerator::InputStdIn.new.lines
        elsif is_file? task.meta[:source]
          task.body = PuppetGenerator::InputFile.new( task.meta[:source] ).lines
        else
          raise PuppetGenerator::Exceptions::InvalidSource
        end

        task.logger.debug(self.class.name) { "count input lines: #{task.body.size}" }

        @app.call(task)
      end

    end
  end
end
