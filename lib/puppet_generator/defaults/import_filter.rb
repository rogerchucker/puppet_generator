module PuppetGenerator
  module Defaults
    class ImportFilter
      def use
        Models::ImportFilter.enable :null
        Models::ImportFilter.enable :yaml
      end
    end
  end
end
