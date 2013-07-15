module PuppetGenerator
  module ExportFilters
    class Null
      def convert(objects, task)
        objects
      end
    end
  end
end
