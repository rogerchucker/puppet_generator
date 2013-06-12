module PuppetGenerator
  module Setup
    module DefaultImportFilter
      def self.use
        Models::ImportFilter.enable :null
        Models::ImportFilter.enable :yaml
      end
    end
  end
end
