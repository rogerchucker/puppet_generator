module PuppetGenerator
  module PuppetObjects
    class Role
      attr_reader :name, :module_name, :includes

      def initialize(entry, module_name, class_name)
        @name = entry[:name] 
        @module_name = module_name

        @includes = entry[:includes] || []
      end

    end
  end
end
