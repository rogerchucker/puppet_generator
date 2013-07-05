module PuppetGenerator
  module Middleware
    class SetupEnvironment
      def initialize(app)
        @app = app
      end

      def call(task)
        init_logger
        init_models
        set_it_up(task)

        @app.call(task)
      end

      private

      def set_it_up(task)
        Models::Default.init
        Models::Setup.init

        Models::Setup.all.each { |s| s.enable }

        active_setup = Models::Setup.find( task.meta[:command_chain].join("_") )
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
