module PuppetGenerator
  module OutputObjects
    class Role

      include PuppetHelper

      attr_reader :name, :path, :module_name, :class_name, :includes

      def initialize(entry)
        @path = entry[:name]
        @module_name = entry[:module]
        @class_name = entry[:class]

        @includes = entry[:includes] || []
      end

      def suggested_file_name
        puppet_manifest_path( path )
      end
      
      def name
        "#{module_name}::#{::File.basename( @path )}"
      end

    end
  end
end
