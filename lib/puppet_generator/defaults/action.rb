module PuppetGenerator
  module Defaults
    module Action
      def self.use
        Models::Action.enable :null
      end
    end
  end
end
