module PuppetGenerator
  module Models
    # model for import action
    module ClassBasedModel

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods

        def require_path(name)
          File.join( PuppetGenerator.gem_load_path, model_name.pluralize.underscore , name.to_s )
        end

        def exception_for_model
          "PuppetGenerator::Exceptions::Invalid#{model_name.singularize}".constantize
        rescue
          raise Exceptions::ExceptionNeedsToBeImplemented, "Exception \"Exceptions::Invalid#{model_name}\" does not exist."
        end

        def check_klass( klass , method)
          raise exception_for_model, "A valid \"#{model_name}\"-class needs to respond to \"#{ method }\"." unless klass.new.respond_to? method
        end

        def build_class_constant(name)
          "PuppetGenerator::#{model_name.pluralize}::#{name.to_s.camelcase}".constantize
        rescue
          raise exception_for_model , "The filename needs to be snakecase and needs to be convertible to the action class name: filename in camelcase."
        end

        def check_method
          raise Exceptions::MethodNeedsToBeImplemented, "Method \"check_method\" does not exist."
        end

        def suffix
          '.rb'
        end

        def load_from_filesystem
          files = Dir.glob( path_to_instances )

          files.each do |f| 
            instance_name = name( f )

            require require_path( instance_name )

            instance_klass = build_class_constant( instance_name )
            check_klass( instance_klass, check_method )
            create( instance_name , instance_klass.new )
          end
        end
      end
    end
  end
end
