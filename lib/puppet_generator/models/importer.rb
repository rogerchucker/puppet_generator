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

      #create new instance of filter model
      def initialize( name , importer )
        super(name)

        @importer = importer
      end

      def self.check_method
        :read
      end

    end
  end
end
