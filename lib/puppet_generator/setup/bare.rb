module PuppetGenerator
  module Setup
    class Bare

      def initialize(options)
        @task = Task.new(options)

        Models::Template.init
        Models::ImportFilter.init
        Models::Action.init
        Models::ErrorMessage.init
        Models::Importer.init
      end

      def create_task
        @task
      end
    end
  end
end
