module PuppetGenerator
  module Setup
    module DefaultImportFilter
      def self.use
        Models::ImportFilter.create :null, Filter::Null.new
        Models::ImportFilter.create :yaml, Filter::Yaml.new
      end
    end
  end
end
