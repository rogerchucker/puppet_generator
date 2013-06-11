module PuppetGenerator
  module PuppetObjects
    class Package
      attr_reader :name, :provider, :version, :module_name, :class_name

      def initialize(entry, module_name, class_name)
        @name = entry[:name]
        @module_name = module_name
        @class_name = class_name

        @version = entry.fetch( :version, 'installed' )
        @provider = entry[:provider]
      end

    end
  end
end
