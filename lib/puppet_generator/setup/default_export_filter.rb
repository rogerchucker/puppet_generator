module PuppetGenerator
  module Setup
    module DefaultExportFilter
      def self.use
        Models::ExportFilter.enable :null
      end
    end
  end
end
