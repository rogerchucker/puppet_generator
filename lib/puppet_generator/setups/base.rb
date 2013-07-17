module PuppetGenerator
  module Setups
    class Base

      private

      def use_defaults_for(*items)
        items.flatten.each do |i| 
          active_default = Models::Default.find(i)
          raise Exceptions::UnknownSetup unless active_default

          active_default.use
        end
      end

      def enable_all_of(*items)
        items.flatten.each do |i| 
          "Models::#{i.camelcase}".constantize.all.each { |t| t.enable }
        end
      rescue Exception => e
        raise Exceptions::UnknownModel, "I'm not able to enable all instances of \"Models::#{i.camelcase}\". Maybe the model is missing or another error happend: #{e.message}"
      end

      def enable_action(*items)
        items.flatten.each { |i| Models::Actions.enable(i) }
      end

      def enable_import_filter(*items)
        items.flatten.each { |i| Models::ImportFilter.enable(i) }
      end

      def enable_importer(*items)
        items.flatten.each { |i| Models::Importer.enable(i) }
      end

      def enable_export_filter(*items)
        items.flatten.each { |i| Models::ExportFilter.enable(i) }
      end

      def enable_exporter(*items)
        items.flatten.each { |i| Models::Exporter.enable(i) }
      end

    end
  end
end
