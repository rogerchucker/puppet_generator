module PuppetGenerator
  module Models
    class Template < Base

      include FilesystemBasedModel

      #create new instance of template model
      def initialize( name , template_path, handles_one_element_only=true )
        super(name)

        @template_path = template_path
        @handles_one_element_only = handles_one_element_only
      end

      #check if template is for one or many
      #elements
      def handles_one_element_only?(val=true)
        @handles_one_element_only == val
      end

      # render the template based on files
      def render(items)

        if handles_one_element_only?
          return items.collect { |item| Definition.new( item.name, template.evaluate( item: item ) ) }
        else
          return [ Definition.new( items.first.class_name , template.evaluate( items: items ) ) ]
        end

      rescue
        raise Exceptions::InvalidTemplate, "An invalid template \"#{@template_path}\" was used. Please check and correct the syntax and try again."
      end

      private

      def template
        Erubis::Eruby.new( template_content )
      rescue
        raise Exceptions::InvalidTemplate, "An invalid template \"#{@template_path}\" was used. Please check and correct the syntax and try again."
      end

      def template_content
        File.read( @template_path )
      end

      public

      class << self

        private

        def path_to_instances
          path = File.expand_path('../../../../templates/puppet', __FILE__ )

          File.join(path,'**', '*.pp.erb')
        end

        def load_from_filesystem
          files = Dir.glob( path_to_instances )

          files.each do |f| 
            create( name( f , '.pp.erb' ) , f, template_is_for_one_element_only?( f ) )
          end

        end

        def template_is_for_one_element_only?(path)
          if path =~ %r[/one/]
            return true
          else
            return false
          end
        end
      end
    end
  end
end
