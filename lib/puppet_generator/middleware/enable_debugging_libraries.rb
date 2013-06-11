module PuppetGenerator
  module Middleware
    class EnableDebuggingLibraries
      def initialize(app)
        @app = app
      end

      def call(task)
        PuppetGenerator.enable_debugging_libraries if task.meta[:debug]

        @app.call(task)
      end
    end
  end
end
