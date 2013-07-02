module PuppetGenerator
  module Defaults
    module ErrorMessage
      def self.use
        Models::ErrorMessage.all.each { |m| m.enable }
      end
    end
  end
end

