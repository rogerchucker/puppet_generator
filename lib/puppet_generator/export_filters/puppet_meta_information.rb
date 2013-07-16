module PuppetGenerator
  module ExportFilters
    class PuppetMetaInformation
      def convert(objects, task)

        objects.collect do |o|
          o.merge!( { 
            module: task.meta[:module],
            class: task.meta[:class],
          } )
        end

        o
      end
    end
  end
end
