module PuppetGenerator
  module Defaults
    class Action
      def use
        Models::Action.enable :null
      end
    end
  end
end
