module PuppetGenerator
  module PuppetObjects
    class File

      include PuppetHelper

      attr_reader :path, :module_name, :class_name, :owner, :mode, :source, :type

      def initialize(entry, module_name, class_name)
        @path = entry[:name]
        @module_name = module_name
        @class_name = class_name

        @owner = entry[:owner]
        @mode = entry[:mode]
        @type = entry.fetch( :type, 'file' )
        @source = entry[:source]
      end

      def name
        ::File.basename(path)
      end

      def suggested_file_name
        puppet_manifest_path( name )
      end
    end
  end
end
