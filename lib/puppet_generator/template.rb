module PuppetGenerator
  class Template

    class << self
      def find(name)
        path = File.join(root, name)
        raise Exceptions::TemplateNotFound unless File.exists? path

        Template.new(path)
      end

      def root
        File.expand_path( '../../../templates', __FILE__ ) 
      end
    end

    def initialize(path)
      @string = File.read(path)
    end

    def render(objects)
      rendered_objects = objects.collect { |o| ERB.new(@string).result(o.binding) }

      rendered_objects.join("\n")
    end

  end
end
