module PuppetGenerator
  module Templates
    class ClassPackage

      attr_reader :packages, :puppet_class

      def initialize(packages)
        @packages = packages
        @string = <<-EOF
class <%= packages.first.module_name %>::<%= packages.first.class_name %> {
<% packages.each do |p| %>
  package {'<%= p.name %>':
    ensure => latest,
  }
<% end %>
}
        EOF
      end

      def render
        ERB.new(@string).result(context)
      end

      private

      def context
        binding
      end

    end
  end
end
