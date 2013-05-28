module PuppetGenerator
  class DetermineTemplates
    def initialize(app)
      @app = app
    end

    def call(task)
      task.body[:templates] = {}

      if task.is_file_task?
        task.body[:entry_creator] = Creators::FileEntry
        task.body[:templates][:class] = Templates::ClassFile
        task.body[:templates][:single] = Templates::SingleFile
        task.body[:filter][:default] = Filter::Plain.new
      elsif task.is_package_task?
        task.body[:entry_creator] = Creators::PackageEntry
        task.body[:templates][:class] = Templates::ClassPackage
        task.body[:templates][:single] = Templates::SinglePackage
        task.body[:filter][:default] = Filter::Plain.new
      elsif task.is_user_task?
        task.body[:entry_creator] = Creators::UserEntry
        task.body[:templates][:class] = Templates::ClassUser
        task.body[:templates][:single] = Templates::SingleUser
        task.body[:filter][:etc_passwd] = Filter::EtcPasswd.new
        task.body[:filter][:default] = Filter::Plain.new
      else
        raise PuppetGenerator::Exceptions::InternalError
      end

      @app.call(task)
    end

  end
end
