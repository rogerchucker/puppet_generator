module PuppetGenerator
  module Defaults
    module ExportFilter
      def self.use
        Models::ExportFilter.enable :null
      end
    end
  end
end
