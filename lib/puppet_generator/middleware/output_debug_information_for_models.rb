module PuppetGenerator
  module Middleware
    class OutputDebugInformationForModels
      def initialize(app)
        @app = app
      end

      def call(task)

        PuppetGenerator.logger.debug(self.class.name){ "Available importer: " +  Models::Importer.all_names_as_string }
        PuppetGenerator.logger.debug(self.class.name){ "Available templates: " +  Models::Template.all_names_as_string }
        PuppetGenerator.logger.debug(self.class.name){ "Available filter: " +  Models::ImportFilter.all_names_as_string }
        PuppetGenerator.logger.debug(self.class.name){ "Available actions: " +  Models::Action.all_names_as_string }

        @app.call(task)
      end

    end
  end
end
