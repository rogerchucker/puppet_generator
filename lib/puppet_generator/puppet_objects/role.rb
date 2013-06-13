module PuppetGenerator
  module PuppetObjects
    class Role

      include PuppetHelper

      attr_reader :name, :path, :module_name, :class_name, :includes

      def initialize(entry, module_name, class_name)
        @path = entry[:name]
        @module_name = entry.fetch(:module_name, module_name )
        @class_name = entry.fetch(:class_name, class_name )

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
