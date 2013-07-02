module PuppetGenerator
  module Middleware
    class SetupEnvironment
      def initialize(app)
        @app = app
      end

      def call(options)
        task = set_it_up(options)

        init_logger
        init_models

        @app.call(task)

        task
      end

      private

      def set_it_up(options)
        Models::Default.init
        Models::Setup.init

        Models::Setup.all.each { |s| s.enable }

        active_setup = Models::Setup.find( options.meta[:command].join("_") )
        raise Exceptions::UnknownSetup unless active_setup

        active_setup.environment 
      end

      def init_logger
        PuppetGenerator::Models.logger = PuppetGenerator.logger
      end
      
      def init_models
        Models::Template.init
        Models::ImportFilter.init
        Models::Action.init
        Models::ErrorMessage.init
        Models::Importer.init
        Models::Exporter.init
        Models::ExportFilter.init
        Models::EntryConverter.init
      end
    end
  end
end
