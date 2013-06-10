module PuppetGenerator
  module Middleware
    class ApplyExportFilters

      def initialize(app)
        @app = app
      end

      def call(task)
        PuppetGenerator.logger.debug(self.class.name){ "Filter the output with filter \"#{task.meta[:requested_export_filter].join(", ")}\"" }

        task.body = apply_filters(task.meta[:requested_export_filter], task.body)

        @app.call(task)
      end

      private

      def apply_filters(filters, data, &block)

        filters.inject(data) do |data,filter|
          active_filter = Models::ExportFilter.find filter
          raise Exceptions::UnknownExportFilter unless active_filter

          data = active_filter.convert(data)
        end
      end

    end
  end
end
