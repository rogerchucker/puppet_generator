module PuppetGenerator
  module Models
    # model for import action
    module FilesystemBasedModel

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods

        #initialize model
        def init
          load_from_filesystem
        end

        private

        def path_to_instances
          path = File.expand_path("../../#{model_name.downcase.pluralize}", __FILE__ )

          File.join(path,'*.rb')
        end

        def name(path)
          name = File.basename(path, '.rb').to_sym
          raise Exceptions::UnauthorizedUseOfKeyword if forbidden_keywords.include? name

          name
        end

        def load_from_filesystem
          raise
        end

        def forbidden_keywords
          [ ]
        end

        def module_name
          name = fqcn
          name.pop

          name.join('::')
        end

        def fqcn
          self.to_s.split(/::/)
        end

        def model_name
          fqcn.last
        end

        def require_path(name)
          File.join( PuppetGenerator.gem_load_path, model_name.downcase.pluralize , name.to_s )
        end

        def check_klass( klass , method)
          raise "Exceptions::Invalid#{model_name}".constantize , "A valid \"#{model_name}\"-class needs to respond to \"#{ method }\"." unless klass.new.respond_to? method
        end

        def build_class_constant(name)
          "PuppetGenerator::#{model_name.pluralize}::#{name.to_s.camelcase}".constantize
        rescue
          raise Exceptions::InvalidAction , "The filename needs to be snakecase and needs to be convertible to the action class name: filename in camelcase."
        end
      end

    end
  end
end
