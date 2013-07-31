module PuppetGenerator
  module Models
    class Setup < FeduxOrg::Stdlib::Models::BaseModel

      include FeduxOrg::Stdlib::Models::FilesystemBasedModel
      include FeduxOrg::Stdlib::Models::ClassBasedModel

      extend Forwardable

      #@!method convert
      #   converts an object using the convert method of 
      #   the stored action
      def_delegator :@setup, :environment, :environment
      def_delegator :@setup, :description, :description

      #create new instance of action model
      def initialize( name , setup )
        super(name)

        @setup = setup
      end

      class << self
        private

        def check_method
          [ :description, :environment ]
        end

        def model_path
          __FILE__
        end

        def ignore
          'base.rb'
        end

        def suffix
          '.rb'
        end
      end
    end
  end
end
