module PuppetGenerator
  module Middleware
    class ApplyExportFilters

      def initialize(app)
        @app = app
      end

      def call(task)
        PuppetGenerator.logger.debug(self.class.name){ "Filter the output with filter \"#{task.meta[:requested_export_filter].join(", ")}\"" }

        task.body = apply_filters(task.meta[:requested_export_filter], task.body, task.meta)

        PuppetGenerator.logger.debug(self.class.name) { "Count output lines: #{task.body.size}" }

        @app.call(task)
      end

      private

      def apply_filters(filters, objects, meta, &block)

        filters.inject(objects) do |objects,filter|
          active_filter = Models::ExportFilter.find filter
          raise Exceptions::UnknownExportFilter unless active_filter

          data = active_filter.convert(objects, meta)
        end
      end

    end
  end
end
