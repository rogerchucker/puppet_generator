module PuppetGenerator
  class Api

    def generate_package_definition(options)

      task = Task.new(options, :package)

      stack = Middleware::Builder.new do
        use ConfigureLogging
        use HandleErrors
        use DetermineTemplates
        use ReadInputPackages
        use CheckForEmptySource
        use FilterImportedData
        use EntryToPackage
        use CreateOutput
      end

      stack.call(task)
    end

    def generate_file_definition(options)

      task = Task.new(options, :file)

      stack = Middleware::Builder.new do
        use ConfigureLogging
        use HandleErrors
        use DetermineTemplates
        use ReadInputFiles
        use CheckForEmptySource
        use FilterImportedData
        use EntryToFile
        use CreateOutput
      end

      stack.call(task)
    end

    def generate_user_definition(options)

      task = Task.new(options, :user)

      stack = Middleware::Builder.new do
        use ConfigureLogging
        use HandleErrors
        use DetermineTemplates
        use ReadInputPackages
        use CheckForEmptySource
        use FilterImportedData
        use EntryToUser
        use CreateOutput
      end

      stack.call(task)
    end

  end
end
