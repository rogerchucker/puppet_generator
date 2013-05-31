module PuppetGenerator
  module Setup
    class Bare

      def initialize(options)
        @task = Task.new(options)
      end

      def create_task
        @task
      end
    end
  end
end
