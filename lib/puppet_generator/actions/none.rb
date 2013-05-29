module PuppetGenerator
  module Actions
    class None
      def run(task)
        task.body
      end
    end
  end
end
