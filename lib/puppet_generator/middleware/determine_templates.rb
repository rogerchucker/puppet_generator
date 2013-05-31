module PuppetGenerator
  module Middleware
    class OutputDebugInformationForModels
      def initialize(app)
        @app = app
      end

      def call(task)
        task.logger.debug(self.class.name){ "Available templates: " +  Models::Template.all_names_as_string }
        task.logger.debug(self.class.name){ "Available filter: " +  Models::ImportFilter.all_names_as_string }
        task.logger.debug(self.class.name){ "Available actions: " +  Models::Action.all_names_as_string }

        @app.call(task)
      end

    end
  end
end
