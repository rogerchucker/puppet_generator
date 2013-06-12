module PuppetGenerator
  module ExportFilters
    class Null
      def convert(objects)
        objects
      end
    end
  end
end
