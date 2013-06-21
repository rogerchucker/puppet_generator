module PuppetGenerator
  class Api

    private

    def pre_stack
      ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::EnableDebuggingLibraries
        use PuppetGenerator::Middleware::ConfigureLogging
      end
    end

    def default_list_stack
      ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::OutputDebugInformationForModels
        use PuppetGenerator::Middleware::HandleErrors
      end
    end

    def _setup(options, klass)
      s = klass.new(options)
      s.setup_environment

      s.create_task
    end

    public

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
