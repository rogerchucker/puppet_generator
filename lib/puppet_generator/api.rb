module PuppetGenerator
  class Api

    def generate_package_definition(options)
      s = Setup::Package.new(options)
      s.setup_environment

      stack = ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::ConfigureLogging
        use PuppetGenerator::Middleware::DetermineTemplates
        use PuppetGenerator::Middleware::HandleErrors
        use PuppetGenerator::Middleware::ReadInputPackages
        use PuppetGenerator::Middleware::CheckForEmptySource
        use PuppetGenerator::Middleware::FilterImportedData
        use PuppetGenerator::Middleware::ExecuteActions
        use PuppetGenerator::Middleware::EntryToPackage
        use PuppetGenerator::Middleware::CreateOutput
      end

      stack.call(s.create_task)
    end

    def generate_file_definition(options)

      s = Setup::File.new(options)
      s.setup_environment

      stack = ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::ConfigureLogging
        use PuppetGenerator::Middleware::DetermineTemplates
        use PuppetGenerator::Middleware::HandleErrors
        use PuppetGenerator::Middleware::ReadInputFiles
        use PuppetGenerator::Middleware::CheckForEmptySource
        use PuppetGenerator::Middleware::FilterImportedData
        use PuppetGenerator::Middleware::ExecuteActions
        use PuppetGenerator::Middleware::EntryToFile
        use PuppetGenerator::Middleware::CreateOutput
      end

      stack.call(s.create_task)
    end

    def generate_user_definition(options)
      task = Task.new(options, :user)

      stack = ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::ConfigureLogging
        use PuppetGenerator::Middleware::DetermineTemplates
        use PuppetGenerator::Middleware::HandleErrors
        use PuppetGenerator::Middleware::ReadInputPackages
        use PuppetGenerator::Middleware::CheckForEmptySource
        use PuppetGenerator::Middleware::FilterImportedData
        use PuppetGenerator::Middleware::ExecuteActions
        use PuppetGenerator::Middleware::EntryToUser
        use PuppetGenerator::Middleware::CreateOutput
      end

      stack.call(task)
    end

    def generate_module(options)
      task = Task.new(options, :module)

      stack = ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::ConfigureLogging
        use PuppetGenerator::Middleware::DetermineTemplates
        use PuppetGenerator::Middleware::HandleErrors
        use PuppetGenerator::Middleware::CreateModuleDirectories
      end

      stack.call(task)
    end

    def output_error_messages(options)
      task = Task.new(options, :error_message)

      stack = ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::ConfigureLogging
        use PuppetGenerator::Middleware::DetermineTemplates
        use PuppetGenerator::Middleware::HandleErrors
        use PuppetGenerator::Middleware::CreateOutput
      end

      stack.call(task)
    end

  end
end
