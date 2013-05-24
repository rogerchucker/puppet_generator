module PuppetGenerator
  class PuppetClass
    attr_reader :name, :module_name

    def initialize(name, module_name)
      @name = name.strip
      @module_name = module_name
    end
  end
end
