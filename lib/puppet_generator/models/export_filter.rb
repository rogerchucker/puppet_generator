module PuppetGenerator
  module Models
    # model for import filter
    class ExportFilter < FeduxOrg::Stdlib::Models::BaseModel

      include FeduxOrg::Stdlib::Models::FilesystemBasedModel
      include FeduxOrg::Stdlib::Models::ClassBasedModel

      extend Forwardable

      #@!method convert
      #   converts an object using the convert method of 
      #   the stored filter
      def_delegator :@filter, :convert, :convert

      public

      #create new instance of filter model
      def initialize( name , filter )
        super(name)

        @filter = filter
      end

      class << self
        def check_method
          :convert
        end

        def forbidden_keywords
          [ :enabled ]
        end

      end

    end
  end
end
