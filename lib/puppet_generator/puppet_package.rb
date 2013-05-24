module PuppetGenerator
  class PuppetPackage
    attr_reader :name, :module_name, :class_name

    def initialize(name, module_name, class_name)
      @name = name.strip
      @module_name = module_name
      @class_name = class_name
    end

  end
end
