module PuppetGenerator
  module Setup
    module DefaultImportFilter
      def included(base)
        Models::ImportFilter.create :null, Filter::Null.new
        Models::ImportFilter.create :yaml, Filter::Yaml.new
        end
