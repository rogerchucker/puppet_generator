module PuppetGenerator
  module Templates
    class SinglePackage

      attr_reader :packages, :puppet_class

      def initialize(packages)
        @packages = packages
        @template = Erubis::Eruby.new( 
        <<-EOF
class <%= @package.module_name %>::<%= @package.name %> {
  package {'<%= @package.name %>':
    ensure => latest,
  }
}
        EOF
        )
      end

      def render
        packages.collect { |p| 
          Definition.new(p.name, @template.evaluate( package: p ) ) 
        }
      end
    end
  end
end
