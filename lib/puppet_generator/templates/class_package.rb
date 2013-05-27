module PuppetGenerator
  module Templates
    class ClassPackage

      attr_reader :packages

      def initialize(packages)
        @packages = packages
        @template = Erubis::Eruby.new(
        <<-EOF
class <%= @packages.first.module_name %>::<%= @packages.first.class_name %> {
<% @packages.each do |p| %>
  package {'<%= p.name %>':
    ensure => latest,
  }
<% end %>
}
        EOF
        )
      end

      def render
        [ Definition.new( packages.first.class_name, @template.evaluate(packages: packages) ) ]
      end

    end
  end
end
