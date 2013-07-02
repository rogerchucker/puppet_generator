module PuppetGenerator
  module Defaults
    class Exporter
      def use
        Models::Exporter.enable :file
        Models::Exporter.enable :stdout
        Models::Exporter.enable :directory
      end
    end
  end
end
