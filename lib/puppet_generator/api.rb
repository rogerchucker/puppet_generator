module PuppetGenerator
  class Api

    def generate_package_definition(options)

      task = Task.new(options, :package)

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

    def generate_file_definition(options)

      task = Task.new(options, :file)

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

    def generate_user_definition(options)

      task = Task.new(options, :user)

      stack = Middleware::Builder.new do
        use HandleErrors
        use ReadInputPackages
        use CheckForEmptySource
        use EntryToUser
        use DetermineTemplates
        use CreateOutput
      end

      stack.call(task)
    end

  end
end
