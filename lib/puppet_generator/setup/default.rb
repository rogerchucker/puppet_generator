module PuppetGenerator
  module Setup
    class Default

      def initialize(options)
        @task = Task.new(options)
      end

      def setup_environment
        Models::ImportFilter.create :plain, Filter::Plain.new
        Models::ImportFilter.create :yaml, Filter::Yaml.new

        Models::Action.create :none, Actions::None.new
      end

      def create_task
        @task
      end

    end
  end
end
