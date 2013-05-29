module PuppetGenerator
  module Middleware
    class DetermineTemplates
      def initialize(app)
        @app = app
      end

      def call(task)
        task.meta[:templates]     = {}
        task.meta[:import_filter] = {}
        task.meta[:actions]       = {}

        #default filter
        task.meta[:import_filter][:plain] = Filter::Plain.new
        task.meta[:import_filter][:yaml] = Filter::Yaml.new

        #default action
        task.meta[:actions][:none] = Actions::None.new

        if task.is_file_task?
          task.meta[:templates][:class] = Templates::ClassFile
          task.meta[:templates][:single] = Templates::SingleFile
          task.meta[:import_filter][:filesystem_attributes] = Filter::FilesystemAttributes.new
          task.meta[:actions][:copy_files_to_module] = Actions::CopyFilesToModuleDirectory.new
        elsif task.is_package_task?
          task.meta[:templates][:class] = Templates::ClassPackage
          task.meta[:templates][:single] = Templates::SinglePackage
        elsif task.is_user_task?
          task.meta[:templates][:class] = Templates::ClassUser
          task.meta[:templates][:single] = Templates::SingleUser
          task.meta[:import_filter][:passwd] = Filter::Passwd.new
        end

        task.logger.debug(self.class.name){ "available templates: " +  option_to_output( task.meta[:templates] ) }
        task.logger.debug(self.class.name){ "available filter: " +  option_to_output( task.meta[:import_filter] ) }
        task.logger.debug(self.class.name){ "available actions: " +  option_to_output( task.meta[:actions] ) }

        @app.call(task)
      end

      private

      def option_to_output(option)
        option.keys.join(", ")
      end

    end
  end
end
