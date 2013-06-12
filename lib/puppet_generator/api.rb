module PuppetGenerator
  class Api

    def pre_stack
      ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::EnableDebuggingLibraries
        use PuppetGenerator::Middleware::ConfigureLogging
      end
    end

    def default_creator_stack
      ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::OutputDebugInformationForModels
        use PuppetGenerator::Middleware::HandleErrors
        use PuppetGenerator::Middleware::ReadInput
        use PuppetGenerator::Middleware::CheckForEmptySource
        use PuppetGenerator::Middleware::FilterImportedData
        use PuppetGenerator::Middleware::ApplyExportFilters
        use PuppetGenerator::Middleware::ExecuteActions
        use PuppetGenerator::Middleware::CreatePuppetObjectFromEntry
        use PuppetGenerator::Middleware::CreateOutput
      end
    end

    def generate_package_definition(options)
      s = Setup::Package.new(options)
      s.setup_environment
      task = s.create_task


      pre_stack.call(task)

      run_with_messages startup_message: "Generating puppet definitions for type \"package\"." do
        default_creator_stack.call(task)
      end
    end

    def generate_file_definition(options)
      s = Setup::File.new(options)
      s.setup_environment
      task = s.create_task

      pre_stack.call(task)

      run_with_messages startup_message: "Generating puppet definitions for type \"file\"." do
        default_creator_stack.call(task)
      end
    end

    def generate_user_definition(options)
      s = Setup::User.new(options)
      s.setup_environment
      task = s.create_task

      pre_stack.call(task)

      run_with_messages startup_message: "Generating puppet definitions for type \"user\"." do
        default_creator_stack.call(task)
      end
    end

    def generate_module(options)
      s = Setup::Module.new(options)
      s.setup_environment
      task = s.create_task

      stack = ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::OutputDebugInformationForModels
        use PuppetGenerator::Middleware::HandleErrors
        use PuppetGenerator::Middleware::CreateModuleDirectories
      end

      pre_stack.call(task)

      run_with_messages startup_message: "Generating files and directories to build a module." do
        stack.call(task)
      end
    end

    def output_error_messages(options)
      task = Task.new(options, :error_message)

      pre = ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::EnableDebuggingLibraries
        use PuppetGenerator::Middleware::ConfigureLogging
      end

      stack = ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::OutputDebugInformationForModels
        use PuppetGenerator::Middleware::HandleErrors
        use PuppetGenerator::Middleware::CreateOutput
      end

      pre.call(task)

      run_with_messages do
        stack.call(task)
      end
    end

    def generate_role_definition(options)
      s = Setup::Role.new(options)
      s.setup_environment
      task = s.create_task

      pre_stack.call(task)

      run_with_messages startup_message: "Generating puppet definitions for type \"role\"." do
        default_creator_stack.call(task)
      end
    end


    private

    def run_with_messages(opts, &block)
      options = {
        startup_message: "Operation successfully started.",
        teardown_message: "Operation successfully ended." 
      }.merge opts

      PuppetGenerator.logger.info(self.class.name) { options[:startup_message] }
      block.call
      PuppetGenerator.logger.info(self.class.name) { options[:teardown_message] }
    end

  end
end
