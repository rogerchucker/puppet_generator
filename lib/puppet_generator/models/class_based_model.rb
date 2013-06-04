
        def require_path(name)
          #File.join( PuppetGenerator.gem_load_path, 'actions', name.to_s )
          raise
        end

        def check_action( action_class )
          #raise Exceptions::InvalidAction , "A valid import action needs to respond to \"run\"." unless action_class.new.respond_to? :run
          raise
        end

        def create_action_class(name)
          "PuppetGenerator::Actions::#{name.to_s.camelcase}".constantize
        rescue
          raise Exceptions::InvalidAction , "The filename needs to be snakecase and needs to be convertible to the action class name: filename in camelcase."
        end
