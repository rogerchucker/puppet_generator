module PuppetGenerator
  class PackageDefinitionsGenerator
    def initialize(packages)
      @packages = packages
    end

    def run
      @packages.collect { |p| PuppetPackageDefinition.new(p) }
    end
  end
end
