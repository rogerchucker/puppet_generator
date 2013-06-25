module PuppetGenerator
  module Api
    class CreateModule < Base

    def module
      task = setup Setup::Module

      pre_stack.call(task)

      run_with_messages startup_message: "Generating files and directories to build a module." do
        default_stack.call(task)
      end
    end

    private

    def default_stack
      ::Middleware::Builder.new do
        use PuppetGenerator::Middleware::OutputDebugInformationForModels
        use PuppetGenerator::Middleware::HandleErrors
        use PuppetGenerator::Middleware::CreateModuleDirectories
      end
    end

    end
  end
end
