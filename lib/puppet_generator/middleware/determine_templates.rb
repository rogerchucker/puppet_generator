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

        Models::ErrorMessage.preambel = "Sorry, but I can't fullfill your request. "
        Models::ErrorMessage.postscript = "\n\n=================\nPlease read the manual on \"http://github.com/maxmeyer/puppet_generator\" for more information on how to use the script."

        Models::ErrorMessage.create 1, "You entered an invalid source \"#{task.meta[:source]}\": it's not a directory or a file or you tell me to use a file/directory which does not exist or is empty. "
        Models::ErrorMessage.create 2, "You entered an invalid output channel: file or directory can be used."
        Models::ErrorMessage.create 3, "The source \"#{task.meta[:source]}\" you tell me to use does not contain any entries. Giving up."
        Models::ErrorMessage.create 4, "There's no import filter \"#{task.meta[:requested_import_filter]}\". Available import filters: #{option_to_output(task.meta[:import_filter])}."
        Models::ErrorMessage.create 5, "The input is no YAML valid for this use case."
        Models::ErrorMessage.create 6, "The input is no passwd file valid for this use case."
        Models::ErrorMessage.create 7, "There's no action \"#{task.meta[:requested_action]}\". Available actions: #{option_to_output(task.meta[:actions])}."

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
