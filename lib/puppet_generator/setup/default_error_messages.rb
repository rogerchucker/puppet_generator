module PuppetGenerator
  module Setup
    module DefaultErrorMessages
      def self.use
        Models::ErrorMessage.all.each { |m| m.enable }
      end
    end
  end
end

