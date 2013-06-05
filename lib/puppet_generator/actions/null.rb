module PuppetGenerator
  module Actions
    class Null
      def run(task)
        task.body
      end
    end
  end
end
