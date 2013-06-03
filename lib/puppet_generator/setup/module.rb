module PuppetGenerator
  module Setup
    class Module < Bare


      def initialize(options)
        super
      end

      def setup_environment
        DefaultErrorMessages.use
      end

    end
  end
end
