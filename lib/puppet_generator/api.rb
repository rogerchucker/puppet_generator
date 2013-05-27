module PuppetGenerator
  class Api

    def generate_package_definition(task)
      stack = Middleware::Builder.new do
        use HandleErrors
        use ReadInputPackages
        use CheckForEmptySource
        use EntryToPackage
        use DetermineTemplates
        use CreateOutput
      end

      stack.call(task)
    end

    def generate_file_definition(task)
      stack = Middleware::Builder.new do
        use HandleErrors
        use ReadInputFiles
        use CheckForEmptySource
        use EntryToFile
        use DetermineTemplates
        use CreateOutput
      end

      stack.call(task)
    end

  end
end
