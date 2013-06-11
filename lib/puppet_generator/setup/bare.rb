module PuppetGenerator
  module Setup
    class Bare

      def initialize(options)
        @options = options

        PuppetGenerator::Models.logger = PuppetGenerator.logger

        Models::Template.init
        Models::ImportFilter.init
        Models::Action.init
        Models::ErrorMessage.init
        Models::Importer.init
        Models::Exporter.init
        Models::ExportFilter.init
        Models::EntryConverter.init
      end

      def create_task
        Task.new(@options)
      end
    end
  end
end
