module PuppetGenerator
  class Api
    class List

    include Hirb::Console

    def list_actions(filter, options)
      _list_actions_package(options) if filter.include? :package
      _list_actions_user(options) if filter.include? :user
      _list_actions_file(options) if filter.include? :file
      _list_actions_all(options) if filter.include? :all

      table Models::Action.find_all(enabled: true), style: :unicode, fields: [ :name ]
    end

    private
    def setup(options, klass)
      s = klass.new(options)
      s.setup_environment

      s.create_task
    end


    def generate_list(options, setup_klass, startup_message)
      task = setup options, setup_klass
      pre_stack.call(task)

      run_with_messages startup_message: startup_message do
        default_list_stack.call(task)
      end
    end

    def _list_actions_all(options)
      generate_list options, Setup::AllActions, "Generating list of all available actions." 
    end

    def _list_actions_user(options)
      generate_list options, Setup::User, "Generating list of actions for type \"user\"." 
    end

    def _list_actions_package(options)
      generate_list options, Setup::Package, "Generating list of actions for type \"package\"." 
    end

    def _list_actions_file(options)
      generate_list options, Setup::File, "Generating list of actions for type \"file\"." 
    end

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
