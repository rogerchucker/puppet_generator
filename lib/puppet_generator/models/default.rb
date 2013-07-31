module PuppetGenerator
  module Models
    class Default < FeduxOrg::Stdlib::Models::BaseModel

      include FeduxOrg::Stdlib::Models::FilesystemBasedModel
      include FeduxOrg::Stdlib::Models::ClassBasedModel

      extend Forwardable

      #@!method convert
      #   converts an object using the convert method of 
      #   the stored action
      def_delegator :@default, :use, :use

      #create new instance of action model
      def initialize( name , default )
        super(name)

        @default = default
      end

      class << self
        private

        def check_method
          :use
        end

        def model_path
          __FILE__
        end
      end
    end
  end
end
