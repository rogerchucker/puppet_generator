module PuppetGenerator
  class PackageTemplate

    def initialize(package)
      @package = package

      @template = <<-EOF
class <%= package.module %>::<%= package.name %> {

  package {'<%= package.name %>':
    ensure => latest,
  }

}
      EOF
    end

    def to_s
      ERB.new(@template).result(context)
    end

    private

    attr_reader :package

    def context
      binding
    end

  end
end
