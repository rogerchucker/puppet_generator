module PuppetGenerator
  module Setup
    module DefaultActions
      def self.use
        Models::Action.enable :null
      end
    end
  end
end
