module PuppetGenerator
  class TemplatePuppetClass

    def initialize(objects, subtemplate)
      @objects = objects
      @subtemplate = subtemplate

      @string = <<-EOF
class <%= module_name %>::<%= class_name %> {
<%= partial @objects, @subtemplate %>
}
      EOF
    end

    def render
      ERB.new(@string).result(context)
    end

    def context
      binding
    end

    def partial(objects, subtemplate)
      out = objects.collect { |o| subtemplate.new(o).render }
      out.join("\n")
    end

  end
end
