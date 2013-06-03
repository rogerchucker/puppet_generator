module PuppetGenerator
  module Models
    # model for import action
    class Action < Base

      extend Forwardable

      #@!method convert
      #   converts an object using the convert method of 
      #   the stored action
      def_delegator :@action, :run, :run

      #create new instance of action model
      def initialize( name , action )
        super(name)

        @action = action
        @enabled = false
      end

      #enable action
      def enable
        @enabled = true
      end

      #check if action is enabled
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

        def action
          path = File.expand_path('../../actions', __FILE__ )

          File.join(path,'*.rb')
        end

        def load_from_filesystem
          files = Dir.glob( action )

          files.each do |f| 
            action_name = name( f )

            require require_path( action_name )

            action_class = create_action_class( action_name )
            check_action( action_class )
            create( action_name , action_class.new )
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
          File.join( PuppetGenerator.gem_load_path, 'actions', name.to_s )
        end

        def check_action( action_class )
          raise Exceptions::InvalidAction , "A valid import action needs to respond to \"run\"." unless action_class.new.respond_to? :run
        end

        def create_action_class(name)
          "PuppetGenerator::Actions::#{name.to_s.camelcase}".constantize
        rescue
          raise Exceptions::InvalidAction , "The filename needs to be snakecase and needs to be convertible to the action class name: filename in camelcase."
        end
      end

    end
  end
end
