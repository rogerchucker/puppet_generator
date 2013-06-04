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

        def suffix
          raise Exceptions::MethodNeedsToBeImplemented
        end

        def path_to_instances
          path = File.expand_path("../../#{model_name.pluralize.underscore}", __FILE__ )

          File.join(path,"*#{suffix}")
        end

        def name(path)
          name = File.basename(path, suffix ).to_sym
          raise Exceptions::UnauthorizedUseOfKeyword if forbidden_keywords.include? name

          name
        end

        def load_from_filesystem
          raise Exceptions::MethodNeedsToBeImplemented
        end

        def forbidden_keywords
          [ ]
        end

      end

    end
  end
end
