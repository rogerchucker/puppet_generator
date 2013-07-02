module PuppetGenerator
  module Defaults
    class ExportFilter
      def use
        Models::ExportFilter.enable :null
      end
    end
  end
end
