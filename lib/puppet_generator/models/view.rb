module PuppetGenerator
  module Models
    class View < FeduxOrg::Stdlib::Models::BaseModel

      include FeduxOrg::Stdlib::Models::FilesystemBasedModel

      #create new instance of view model
      def initialize( view_path )
        @supported_input_identifier = determine_supported_input_identifier( view_path )
        @name = determine_name( view_path )
        @view_path = view_path
        @verb = determine_verb( view_path )
        @resource = determine_resource( view_path )
      end

      def path
        @view_path
      end

      def verb?(other)
        @verb == other.to_sym
      end

      def resource?(other)
        @resource == other.to_sym
      end

      #check if a view is tagged 
      def supports_enum_as_input?(expected_result = true)
        ( :many == @supported_input_identifier ) == expected_result
      end

      public

      # render the view based on files
      def render(items)

        if supports_enum_as_input?
          return [ Definition.new( nil , view.evaluate( items: items ) ) ]
        else 
          return items.collect { |item| Definition.new( item.suggested_file_name, view.evaluate( item: item ) ) }
        end

      rescue Exception => e
        raise Exceptions::InvalidTemplate, "An invalid view \"#{@view_path}\" was used. Please check and correct the syntax and try again. The original error message was: #{e.message}."
      end

      private

      def determine_verb(view_path)
        File.basename( view_path, '.erb' ).match(/^([^+]+)/) { $1 }.to_sym
      end

      def determine_resource(view_path)
        File.basename( File.dirname( view_path ) ).to_sym
      end

      def determine_name(view_path)
        name = []
        name.push( determine_verb(view_path) )
        name.push( determine_resource(view_path) )
        name.push( determine_supported_input_identifier(view_path) )

        name.join('_').to_sym
      end

      def determine_supported_input_identifier(view_path)
        File.basename( view_path, '.erb' ).match(/\+([^+]+)\+/) { $1 }.to_sym
      end

      def view
        Erubis::Eruby.new( view_content )
      end

      def view_content
        File.read( @view_path )
      end

      public

      class << self

        private

        def suffix
          '.erb'
        end

        def path_to_instances
          prefix = File.expand_path("../../../../app/views", model_path )

          File.join(prefix,'**', "*#{ suffix }")
        end

        def load_from_filesystem
          files = Dir.glob( path_to_instances )

          raise FeduxOrg::Stdlib::Models::Exceptions::NoImplementationsForModelFound, "You might need to store files at \"#{File.dirname(path_to_instances)}\" to make the library work." if files.blank?

          files.each { |f| create( f ) }
        end

        def model_path
          __FILE__
        end
      end
    end
  end
end
