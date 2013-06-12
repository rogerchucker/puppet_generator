module PuppetGenerator
  module Setup
    module DefaultExporter
      def self.use
        Models::Exporter.enable :file
        Models::Exporter.enable :stdout
        Models::Exporter.enable :directory
      end
    end
  end
end
