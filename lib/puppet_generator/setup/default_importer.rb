module PuppetGenerator
  module Setup
    module DefaultImporter
      def self.use
        Models::Importer.enable :file
        Models::Importer.enable :stdin
      end
    end
  end
end
