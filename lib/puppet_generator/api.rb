module PuppetGenerator
  class Api

    def generate_package_definition(task)
      stack = Middleware::Builder.new do
        use HandleErrors
        use ReadInput
        use EntryToPackage
        use CreateOutput
      end

      stack.call(task)
    end

  end
end
