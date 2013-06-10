module PuppetGenerator
  module Models
    class Template < FeduxOrg::Stdlib::Models::BaseModel

      include FeduxOrg::Stdlib::Models::FilesystemBasedModel

      #create new instance of template model
      def initialize( name , template_path, suitable_outputs=[], tags=[] )
        super(name)

        @template_path = template_path
        @suitable_outputs = suitable_outputs
        @tags = tags
      end

      #output path to template
      def path
        @template_path
      end

      #check if a template is suitable for 
      #a given output
      def is_suitable_for?(output)
        @suitable_outputs.include? output
      end

      #check if a template is tagged 
      def is_tagged_with?(asked_tags)
        if asked_tags
          return asked_tags.all? { |t| @tags.include? t }
        else
          return true
        end
      end

      # render the template based on files
      def render(items)

        if @tags.include? :many_per_file
          return [ Definition.new( items.first.class_name , template.evaluate( items: items ) ) ]
        elsif @tags.include? :one_per_file
          return items.collect { |item| Definition.new( item.name, template.evaluate( item: item ) ) }
        else
          raise
        end

      rescue Exception => e
        raise Exceptions::InvalidTemplate, "An invalid template \"#{@template_path}\" was used. Please check and correct the syntax and try again. The original error message was: #{e.message}."
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

          raise FeduxOrg::Stdlib::Models::Exceptions::NoImplementationsForModelFound, "You might need to store files at \"#{File.dirname(path_to_instances)}\" to make the library work." if files.blank?

          files.each do |f| 
            create( name( f ) , f, suitable_outputs_for_path( f ), create_tags( f ) )
          end

        end

        def create_tags(path)
          return case path 
                 when %r[one_per_file]
                   [ :one_per_file ]
                 when %r[many_per_file]
                   [ :many_per_file ]
                 end
        end

        def suitable_outputs_for_path(path)
          return case path 
                 when %r[one_per_file]
                   [ :directory, :dir, :stdout , :file ]
                 when %r[many_per_file]
                   [ :file , :stdout ]
                 else
                   [ :file , :stdout ]
                 end
        end

        def path
          __FILE__
        end
      end
    end
  end
end
