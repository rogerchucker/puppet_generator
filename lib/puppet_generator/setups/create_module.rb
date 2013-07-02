module PuppetGenerator
  module Setups
    class CreateModule < Bare

      def description
        "Create module"
      end

      def environment
        use_defaults_for :error_message
      end

    end
  end
end
