module PuppetGenerator
  module Defaults
    module ImportFilter
      def self.use
        Models::ImportFilter.enable :null
        Models::ImportFilter.enable :yaml
      end
    end
  end
end
