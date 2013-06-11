module PuppetGenerator
  module PuppetObjects
    class Role

      include PuppetHelper

      attr_reader :name, :module_name, :class_name, :includes

      def initialize(entry, module_name, class_name)
        @name = entry[:name] 
        @module_name = entry.fetch(:module_name, module_name )
        @class_name = entry.fetch(:class_name, class_name )

        @includes = entry[:includes] || []
      end

    end
  end
end
