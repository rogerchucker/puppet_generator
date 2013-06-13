module PuppetGenerator
  module Models
    # model for entry converter filter
    class EntryConverter < FeduxOrg::Stdlib::Models::BaseModel

      include FeduxOrg::Stdlib::Models::FilesystemBasedModel
      include FeduxOrg::Stdlib::Models::ClassBasedModel

      extend Forwardable

      #@!method convert
      #   converts an object using the convert method of 
      #   the stored filter
      def_delegator :@converter, :convert, :convert

      #create new instance of filter model
      def initialize( name , converter )
        super(name)

        @converter = converter
      end

      class << self

        private

        def check_method
          :convert
        end

        def path
          __FILE__
        end

      end

    end
  end
end
