module PuppetGenerator
  module Models
    # model for import action
    class Action < Base

      include FilesystemBasedModel
      include ClassBasedModel

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

      def self.check_method
        :run
      end
    end
  end
end
