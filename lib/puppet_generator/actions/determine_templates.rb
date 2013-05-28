module PuppetGenerator
  class DetermineTemplates
    def initialize(app)
      @app = app
    end

    def call(task)
      task.meta[:templates] = {}
      task.meta[:import_filter]    = {}

      task.logger.debug("determine the templates")

      if task.is_file_task?
        task.meta[:entry_creator] = Creators::FileEntry
        task.meta[:templates][:class] = Templates::ClassFile
        task.meta[:templates][:single] = Templates::SingleFile
        task.meta[:import_filter][:plain] = Filter::Plain.new
      elsif task.is_package_task?
        task.meta[:entry_creator] = Creators::PackageEntry
        task.meta[:templates][:class] = Templates::ClassPackage
        task.meta[:templates][:single] = Templates::SinglePackage
        task.meta[:import_filter][:plain] = Filter::Plain.new
      elsif task.is_user_task?
        task.meta[:entry_creator] = Creators::UserEntry
        task.meta[:templates][:class] = Templates::ClassUser
        task.meta[:templates][:single] = Templates::SingleUser
        task.meta[:import_filter][:passwd] = Filter::EtcPasswd.new
        task.meta[:import_filter][:plain] = Filter::Plain.new
      else
        raise PuppetGenerator::Exceptions::InternalError
      end

      task.logger.debug("available templates: " +  option_to_output( task.meta[:templates] ) )
      task.logger.debug("available filter: " +  option_to_output( task.meta[:import_filter] ) )

      @app.call(task)
    end

    private

    def option_to_output(option)
      option.keys.join(", ")
    end

  end
end
