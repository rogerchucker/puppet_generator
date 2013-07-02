module PuppetGenerator
  module Default
    module Exporter
      def self.use
        Models::Exporter.enable :file
        Models::Exporter.enable :stdout
        Models::Exporter.enable :directory
      end
    end
  end
end
