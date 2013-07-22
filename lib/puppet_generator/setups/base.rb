module PuppetGenerator
  module Setups
    class Base

      private

      def use_defaults_for(*items)
        items.flatten.each do |i| 
          active_default = Models::Default.find(i)
          raise Exceptions::UnknownSetup, "I'm not enable to find default model for \"#{i}\"" unless active_default

          active_default.use
        end
      end

      def enable_all_of(*items)
        items.flatten.each do |i| 
          "PuppetGenerator::Models::#{i.to_s.camelcase}".constantize.all.each { |t| t.enable }
        end
      rescue Exception => e
        raise Exceptions::UnknownModel, "I'm not able to enable all instances of \"Models::#{i.camelcase}\". Maybe the model is missing or another error happend: #{e.message}"
      end

      def enable_action(*items)
        enable_items_for Models::Action, items
      end

      def enable_import_filter(*items)
        enable_items_for Models::ImportFilter, items
      end

      def enable_importer(*items)
        enable_items_for Models::Importer, items
      end

      def enable_export_filter(*items)
        enable_items_for Models::ExportFilter, items
      end

      def enable_exporter(*items)
        enable_items_for Models::Exporter, items
      end

      def enable_items_for( klass, *items )
        items.flatten.each { |i| klass.enable(i) }
      end

      def initialize
        Models::View.init
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
