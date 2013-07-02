module PuppetGenerator
  module Defaults
    module Importer
      def self.use
        Models::Importer.enable :file
        Models::Importer.enable :stdin
      end
    end
  end
end
