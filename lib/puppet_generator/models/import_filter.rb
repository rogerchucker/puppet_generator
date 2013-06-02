module PuppetGenerator
  module Models
    class ImportFilter < Base

      extend Forwardable
      def_delegator :@filter, :convert, :convert

      attr_reader :filter

      def initialize( name , filter )
        super(name)

        @filter = filter
      end

      class << self

        def init
          load_from_filesystem
        end

        def all_names_as_string(connector=", ")
          all.map(&:name).join(connector)
        end

        private

        def filter
          path = File.expand_path('../../filter', __FILE__ )

          File.join(path,'*.rb')
        end

        def load_from_filesystem
          files = Dir.glob(filter)

          files.each do |f| 
            require f
            create( name(f), f )
          end

        end

        def name(path)
          File.basename(path, '.rb').to_sym
        end

        def require_path(name)

        end

        def filter_class(name)
          name.camelcase.constantize
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
