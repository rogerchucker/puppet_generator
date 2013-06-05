module PuppetGenerator
  module Models
    class Template < Base

      include FilesystemBasedModel

      #create new instance of template model
      def initialize( name , template_path, suitable_outputs=[] )
        super(name)

        @template_path = template_path
        @suitable_outputs = suitable_outputs
      end

      #check if a template is suitable for 
      #a given output
      def is_suitable_for?(output)
        @suitable_outputs.include? output
      end

      # render the template based on files
      def render(items)

        if @suitable_outputs.include? :file or @suitable_outputs.include? :stdout
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

        def suffix
          '.pp.erb'
        end

        def path_to_instances
          path = File.expand_path("../../../../#{model_name.downcase.pluralize}/puppet", __FILE__ )

          File.join(path,'**', "*#{ suffix }")
        end

        def load_from_filesystem
          files = Dir.glob( path_to_instances )

          files.each do |f| 
            create( name( f ) , f, suitable_outputs_for_path( f ) )
          end

        end

        def suitable_outputs_for_path(path)
          if path =~ %r[/one/]
            return [ :file, :stdout ]
          else
            return [ :directory, :dir ]
          end
        end
      end
    end
  end
end
