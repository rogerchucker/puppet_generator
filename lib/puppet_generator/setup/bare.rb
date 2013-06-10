module PuppetGenerator
  module Setup
    class Bare

      def initialize(options)
        @task = Task.new(options)

        PuppetGenerator::Models.logger = PuppetGenerator.logger

        Models::Template.init
        Models::ImportFilter.init
        Models::Action.init
        Models::ErrorMessage.init
        Models::Importer.init
        Models::Exporter.init
        Models::ExportFilter.init
      end

      def create_task
        @task
      end
    end
  end
end
