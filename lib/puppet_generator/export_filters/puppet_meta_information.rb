module PuppetGenerator
  module ExportFilters
    class PuppetMetaInformation
      def convert(objects, meta)

        objects.collect do |o|
          o.merge!( { 
            module: meta[:module],
            class: meta[:class],
          } )
        end
      end
    end
  end
end
