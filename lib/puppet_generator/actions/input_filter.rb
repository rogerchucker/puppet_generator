module PuppetGenerator
  class InputFilter
    def initialize(app)
      @app = app
    end

    def call(task)
      task.logger.debug(self.class.name){ "filter the input with filter \"#{task.meta[:requested_import_filter]}\"" }

      begin
        active_filter = task.meta[:import_filter].fetch( task.meta[:requested_import_filter].to_sym )
      rescue
        raise Exceptions::UnknownInputFilter unless active_filter
      end

      task.body = task.body.entries.collect { |line| active_filter.convert(line) }

      @app.call(task)
    end

  end
end
