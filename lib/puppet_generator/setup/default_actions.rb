module PuppetGenerator
  module Setup
    module DefaultActions
      def self.use
        Models::Action.create :null, Actions::Null.new
      end
    end
  end
end
