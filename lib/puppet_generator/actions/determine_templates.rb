module PuppetGenerator
  class DetermineTemplates
    def initialize(app)
      @app = app
    end

    def call(task)
      task.meta[:templates] = {}
      task.meta[:filter]    = {}

      task.logger.debug("Now I'm going to determine the templates")

      if task.is_file_task?
        task.meta[:entry_creator] = Creators::FileEntry
        task.meta[:templates][:class] = Templates::ClassFile
        task.meta[:templates][:single] = Templates::SingleFile
        task.meta[:filter][:default] = Filter::Plain.new
      elsif task.is_package_task?
        task.meta[:entry_creator] = Creators::PackageEntry
        task.meta[:templates][:class] = Templates::ClassPackage
        task.meta[:templates][:single] = Templates::SinglePackage
        task.meta[:filter][:default] = Filter::Plain.new
      elsif task.is_user_task?
        task.meta[:entry_creator] = Creators::UserEntry
        task.meta[:templates][:class] = Templates::ClassUser
        task.meta[:templates][:single] = Templates::SingleUser
        task.meta[:filter][:etc_passwd] = Filter::EtcPasswd.new
        task.meta[:filter][:default] = Filter::Plain.new
      else
        raise PuppetGenerator::Exceptions::InternalError
      end

      @app.call(task)
    end

  end
end
