module PuppetGenerator
  module Models
    class ImportFilter < Base

      extend Forwardable
      def_delegator :@filter, :convert, :convert

      attr_reader :filter

      def initialize( name , filter )
        super(name)

        @filter = filter
        @activated = false
      end

      def activate
        @activated = true
      end

      def activated?
        @activated == true
      end

      class << self

        def init
          load_from_filesystem
        end

        def all_names_as_string(connector=", ")
          all.map(&:name).join(connector)
        end

        def activate(name)
          find(name).activate
        end

        private

        def filter
          path = File.expand_path('../../filter', __FILE__ )

          File.join(path,'*.rb')
        end

        def load_from_filesystem
          files = Dir.glob( filter )

          files.each do |f| 
            filter_name = name( f )

            require require_path( filter_name )

            filter_class = create_filter_class( filter_name )
            check_filter( filter_class )
            create( filter_name , filter_class.new )
          end

        end

        def name(path)
          name = File.basename(path, '.rb').to_sym
          raise Exceptions::UnauthorizedUseOfKeyword if forbidden_keywords.include? name

          name
        end

        def forbidden_keywords
          [ :activated ]
        end

        def require_path(name)
          File.join( PuppetGenerator.gem_load_path, 'filter', name.to_s )
        end

        def check_filter( filter_class )
          raise Exceptions::InvalidImportFilter , "A valid import filter needs to respond to \"convert\"." unless filter_class.new.respond_to? :convert
        end

        def create_filter_class(name)
          "PuppetGenerator::Filter::#{name.to_s.camelcase}".constantize
        rescue
          raise Exceptions::InvalidImportFilter , "The filename needs to be snakecase and needs to be convertible to the filter class name: filename in camelcase."
        end
      end

      def initialize(name, path)
        super(name)
        @path = path
      end

    end
  end
end
