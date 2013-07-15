module PuppetGenerator
  module Middleware
    class GenerateVersion
      def initialize(app)
        @app = app
      end

      def call(task)
        task.body = [ { name: PuppetGenerator::VERSION } ]
        task.meta[:destination] = 'stdout'
        task.meta[:type_of_view] = :one

        @app.call(task)
      end
    end
  end
end
