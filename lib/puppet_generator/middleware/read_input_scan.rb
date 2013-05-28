module PuppetGenerator
  module Middleware
    class ReadInputScan

      include ReadInputHelper

      def initialize(app)
        @app = app
      end

      def call(task)
        if is_directory? task.meta[:source]
          task.body = PuppetGenerator::InputDirectory.new( task.meta[:source], with_meta_data: true )
          task.meta[:input_format] = 'yaml'
        else
          raise PuppetGenerator::Exceptions::InvalidSource
        end

        @app.call(task)
      end

    end
  end
end
