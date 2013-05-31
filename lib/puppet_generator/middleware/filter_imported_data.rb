module PuppetGenerator
  module Middleware
    class FilterImportedData

      def initialize(app)
        @app = app
      end

      def call(task)
        task.logger.info(self.class.name){ "Filter the input with filter \"#{task.meta[:requested_import_filter]}\"" }

        active_filter = Models::ImportFilter.find task.meta[:requested_import_filter]
        raise Exceptions::UnknownImportFilter unless active_filter

        task.body = active_filter.convert(task.body)

        @app.call(task)
      end

    end
  end
end
