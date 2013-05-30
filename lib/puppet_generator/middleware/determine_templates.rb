module PuppetGenerator
  module Middleware
    class DetermineTemplates
      def initialize(app)
        @app = app
      end

      def call(task)
        task.logger.debug(self.class.name){ "available templates: " +  Models::Template.all_names_as_string }
        task.logger.debug(self.class.name){ "available filter: " +  Models::ImportFilter.all_names_as_string }
        task.logger.debug(self.class.name){ "available actions: " +  Models::Action.all_names_as_string }

        @app.call(task)
      end

    end
  end
end
