module PuppetGenerator
  module Defaults
    class Importer
      def use
        Models::Importer.enable :file
        Models::Importer.enable :stdin
      end
    end
  end
end
