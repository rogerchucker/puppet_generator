module PuppetGenerator
  class PuppetPackage
    attr_reader :name, :provider, :module_name, :class_name

    def initialize(entry, module_name, class_name)
      @name = entry[:name]
      @module_name = module_name
      @class_name = class_name

      @version = entry.fetch( :version, 'installed' )
      @provider = entry[:provider]
    end

  end
end
