module PuppetGenerator
  class TemplatePuppetClass

    def initialize(puppet_class, puppet_packages)
      @puppet_class = puppet_class
      @puppet_packages = puppet_packages

      @string = <<-EOF
class <%= @puppet_class.module_name %>::<%= @puppet_class.name %> {
<% @puppet_packages.each do |o| %>
  package {'<%= o.name %>':
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
