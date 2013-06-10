module PuppetGenerator
  module Models
    # model for import action
    class Action < FeduxOrg::Stdlib::Models::BaseModel

      include FeduxOrg::Stdlib::Models::FilesystemBasedModel
      include FeduxOrg::Stdlib::Models::ClassBasedModel

      extend Forwardable

      #@!method convert
      #   converts an object using the convert method of 
      #   the stored action
      def_delegator :@action, :run, :run

      #create new instance of action model
      def initialize( name , action )
        super(name)

        @action = action
      end

      class << self
        private

        def check_method
          :run
        end

        def path
          __FILE__
        end
      end
    end
  end
end
