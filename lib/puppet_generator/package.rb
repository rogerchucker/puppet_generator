module PuppetGenerator
  class Package
    attr_reader :name, :module_name

    def initialize(name,module_name)
      @name = name.strip
      @module_name = module_name.strip
    end

    def to_s(template=PackageTemplate)
      template.new(self).to_s
    end

  end
end
