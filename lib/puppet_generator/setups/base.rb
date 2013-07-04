module PuppetGenerator
  module Setup
    class Bare

      def initialize(options)
        @options = options
      end

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

      def enable_template_for(item)
        Models::Template.find_all(item).each { |t| t.enable }
      end

      def enable_import_filter(item)
        Models::ImportFilter.enable(item)
      end

      def enable_importer(item)
        Models::Importer.enable(item)
      end

      def enable_export_filter(item)
        Models::ExportFilter.enable(item)
      end

      def enable_exporter(item)
        Models::Exporter.enable(item)
      end

    end
  end
end
