module PuppetGenerator
  module Middleware
    class ApplyExportFilters

      def initialize(app)
        @app = app
      end

      def call(task)
        PuppetGenerator.logger.debug(self.class.name){ "Filter the output with filter \"#{task.meta[:requested_export_filter]}\"" }

        active_filter = Models::ExportFilter.find task.meta[:requested_export_filter]
        raise Exceptions::UnknownExportFilter unless active_filter

        task.body = active_filter.convert(task.body)

        @app.call(task)
      end

    end
  end
end
