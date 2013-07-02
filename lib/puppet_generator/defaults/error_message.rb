module PuppetGenerator
  module Defaults
    class ErrorMessage
      def use
        Models::ErrorMessage.all.each { |m| m.enable }
      end
    end
  end
end

