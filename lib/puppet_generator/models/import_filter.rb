module PuppetGenerator
  module Models
    # model for import filter
    class ImportFilter < Base

      extend Forwardable

      #@!method convert
      #   converts an object using the convert method of 
      #   the stored filter
      def_delegator :@filter, :convert, :convert

      #@!attribute [r] :filter
      #   access to the filter stored in instance
      attr_reader :filter

      #create new instance of filter model
      def initialize( name , filter )
        super(name)

        @filter = filter
        @enabled = false
      end

      #enable filter
      def enable
        @enabled = true
      end

      #check if filter is enabled
      def enabled?(val=true)
        @enabled == val
      end

      class << self

        #initialize model
        def init
          load_from_filesystem
        end

        #return all names as string
        def all_names_as_string(connector=", ")
          find_all(enabled: true).map(&:name).join(connector)
        end

        #enables a specific instance
        def enable(name)
          find(name: name).enable
        end

        #finds a single instance
        def find( criteria={} )
          find_all( criteria ).first
        end

        #finds all instances
        def find_all( criteria={} )
          criteria = { name: criteria.to_sym } if criteria.kind_of? Symbol or criteria.kind_of? String

          @instances.find_all do |i| 
            criteria.all? do |c,v|
              i.send( "#{c}?".to_sym , v )
            end
          end

        rescue
          raise Exceptions::InvalidSearchCriteria
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
          [ :enabled ]
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

    end
  end
end
