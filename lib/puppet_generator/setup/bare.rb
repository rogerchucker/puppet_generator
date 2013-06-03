module PuppetGenerator
  module Setup
    class Bare

      def initialize(options)
        @task = Task.new(options)

        Models::Template.init
        Models::ImportFilter.init
        Models::Action.init
      end

      def create_task
        @task
      end
    end
  end
end
