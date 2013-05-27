module PuppetGenerator
  class DetermineTemplates
    def initialize(app)
      @app = app
    end

    def call(task)
      task.body[:templates] = {}

      if task.is_file_task?
        task.body[:templates][:class] = Templates::ClassFile
        task.body[:templates][:single] = Templates::SingleFile
      elsif task.is_package_task?
        task.body[:templates][:class] = Templates::ClassPackage
        task.body[:templates][:single] = Templates::SinglePackage
      else
        raise PuppetGenerator::Exceptions::InternalError
      end

      @app.call(task)
    end

  end
end
