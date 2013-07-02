module PuppetGenerator
  module Setups
    class ListActions < Bare

      def description
        "List all available actions"
      end

      def environment
        use_defaults_for :error_message
        enable_all_of :action
      end

    end
  end
end
