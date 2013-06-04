module PuppetGenerator
  module Models
    # model for import action
    class FilesystemBasedModel < Base

      #create new instance of file system based model
      def initialize(*args, &block)
        super(*args, &block)
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

        def load_from_filesystem
          raise
        end

        def name(path)
          name = File.basename(path, '.rb').to_sym
          raise Exceptions::UnauthorizedUseOfKeyword if forbidden_keywords.include? name

          name
        end

        def forbidden_keywords
          [ ]
        end
      end

    end
  end
end
