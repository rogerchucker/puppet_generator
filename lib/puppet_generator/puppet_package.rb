module PuppetGenerator
  class PuppetPackage
    attr_reader :name

    def initialize(name)
      @name = name.strip
    end

  end
end
