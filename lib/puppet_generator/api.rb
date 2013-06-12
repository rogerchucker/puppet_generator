module PuppetGenerator
  class Api

    private

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

    def _generate_definition(options, setup_klass, startup_message)
      task = _setup options, setup_klass
      pre_stack.call(task)

      run_with_messages startup_message: startup_message do
        default_creator_stack.call(task)
      end
    end

    def _setup(options, klass)
      s = klass.new(options)
      s.setup_environment

      s.create_task
    end

    public

    def generate_package_definition(options)
      _generate_definition options, Setup::Package, "Generating puppet definitions for type \"package\"." 
    end

    def generate_file_definition(options)
      _generate_definition options, Setup::File, "Generating puppet definitions for type \"file\"." 
    end

    def generate_user_definition(options)
      _generate_definition options, Setup::User, "Generating puppet definitions for type \"user\"." 
    end

    def generate_role_definition(options)
      _generate_definition options, Setup::Role, "Generating puppet definitions for type \"role\"." 
    end

    def generate_module(options)
      task = _setup options, Setup::Module

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

      stack = ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::OutputDebugInformationForModels
        use PuppetGenerator::Middleware::HandleErrors
        use PuppetGenerator::Middleware::CreateOutput
      end

      pre_stack.call(task)

      run_with_messages do
        stack.call(task)
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
