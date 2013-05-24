module PuppetGenerator
  class PuppetPackageDefinition

    attr_reader :name

    def initialize(name)
      @name = name.strip
      @template = <<-EOF
class development::apps::<%= name %> {

  package {'<%= name %>':
    ensure => latest,
  }

}
      EOF
    end

    def to_s
      ERB.new(@template).result(context)
    end

    private

    def context
      binding
    end

  end
end
