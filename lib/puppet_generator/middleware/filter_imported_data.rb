module PuppetGenerator
  module Middleware
    class FilterImportedData

      def initialize(app)
        @app = app
      end

      def call(task)
        task.logger.debug(self.class.name){ "filter the input with filter \"#{task.meta[:requested_import_filter]}\"" }

        begin
          active_filter = Models::ImportFilter.find task.meta[:requested_import_filter]
        rescue
          raise Exceptions::UnknownImportFilter unless active_filter
        end

        task.body = active_filter.convert(task.body)

        @app.call(task)
      end

    end
  end
end
