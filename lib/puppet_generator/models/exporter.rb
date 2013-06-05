module PuppetGenerator
  module Models
    # model for import filter
    class Exporter < Base

      include FilesystemBasedModel
      include ClassBasedModel

      extend Forwardable

      #@!method convert
      #   converts an object using the convert method of 
      #   the stored filter
      def_delegator :@exporter, :write, :write
      def_delegator :@exporter, :writes_to?, :writes_to?

      #create new instance of filter model
      def initialize( name , exporter )
        super(name)

        @exporter = exporter
      end

      class << self

        def existing_destination?(destination)
          return true if File.exists? destination

          false
        end

        def valid_destination?(destination)
          return true if find( writes_to: destination, enabled: true )

          false
        end


        def check_method
          :write
        end
      end

    end
  end
end
