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

      class << self
        #initialize model
        def init
          load_from_filesystem
        end

        private

        def action
          path = File.expand_path('../../actions', __FILE__ )

          File.join(path,'*.rb')
        end

        def name(path)
          name = File.basename(path, '.rb').to_sym
          raise Exceptions::UnauthorizedUseOfKeyword if forbidden_keywords.include? name

          name
        end

        def load_from_filesystem
          files = Dir.glob( action )

          files.each do |f| 
            action_name = name( f )

            require require_path( action_name )

            action_class = build_class_constant( action_name )
            check_klass( action_class, :run )
            create( action_name , action_class.new )
          end

        end

        def forbidden_keywords
          [ ]
        end

        def module_name
          fqdn = self.to_s.split(/::/)
          fqdn.pop

          fqdn.join('::')
        end

        def class_name
          self.to_s.split(/::/).last
        end

        def require_path(name)
          debugger
          File.join( PuppetGenerator.gem_load_path, class_name.downcase , name.to_s )
        end

        def check_klass( klass , method)
          raise Exceptions::InvalidAction , "A valid \"#{self.class.name}\"-class needs to respond to \"#{ method }\"." unless klass.new.respond_to? method
        end

        def build_klass_constant(name)
          "#{module_name}::#{name.to_s.camelcase}".constantize
        rescue
          raise Exceptions::InvalidAction , "The filename needs to be snakecase and needs to be convertible to the action class name: filename in camelcase."
        end
      end

    end
  end
end
