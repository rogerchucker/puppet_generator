module PuppetGenerator
  class Api

    def generate_package_definition(options)

      task = Task.new(options, :package)

      stack = Middleware::Builder.new do
        use ConfigureLogging
        use HandleErrors
        use DetermineTemplates
        use ReadInputPackages
        use InputFilter
        use CheckForEmptySource
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
        use InputFilter
        use CheckForEmptySource
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
        use InputFilter
        use CheckForEmptySource
        use EntryToUser
        use CreateOutput
      end

      stack.call(task)
    end

  end
end
