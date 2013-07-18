module PuppetGenerator
  module OutputObjects
    class Package

      include PuppetHelper

      attr_reader :name, :provider, :version, :module_name, :class_name

      def initialize(entry)
        @name = entry[:name]
        @module_name = entry[:module]
        @class_name = entry[:class]

        @version = entry.fetch( :version, 'installed' )
        @provider = entry[:provider]
      end

      def suggested_file_name
        puppet_manifest_path( name )
      end

    end
  end
end
