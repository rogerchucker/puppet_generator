module PuppetGenerator
  module Models
    class Action < Base

      extend Forwardable
      def_delegator :@action, :run, :run

      attr_reader :action

      def initialize( name , action )
        super(name)

        @action = action
      end

      def self.all_names_as_string(connector=", ")
        all.map(&:name).join(connector)
      end

    end
  end
end
