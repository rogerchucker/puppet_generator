module PuppetGenerator
  module Models
    # model for import filter
    class Importer < Base

      include FilesystemBasedModel
      include ClassBasedModel

      extend Forwardable

      #@!method convert
      #   converts an object using the convert method of 
      #   the stored filter
      def_delegator :@importer, :read, :read
      def_delegator :@importer, :reads_from?, :reads_from?

      #create new instance of filter model
      def initialize( name , importer )
        super(name)

        @importer = importer
      end

      class << self

        def existing_source?(source)
          return true if find( reads_from: source )

          false
        end

        def valid_source?(source)
          return true if find( reads_from: source, enabled: true )

          false
        end


        def check_method
          :read
        end
      end

    end
  end
end
