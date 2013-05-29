module PuppetGenerator
  module Middleware
    class DetermineTemplates
      def initialize(app)
        @app = app
      end

      def call(task)
        task.meta[:templates]     = {}

        #default filter
        Models::ImportFilter.create :plain, Filter::Plain.new
        Models::ImportFilter.create :yaml, Filter::Yaml.new

        #default action
        Models::Action.create :none, Actions::None.new

        if task.is_file_task?
          Models::Template.create :class, Templates::ClassFile
          Models::Template.create :single, Templates::SingleFile
          Models::ImportFilter.create :filesystem_attributes, Filter::FilesystemAttributes.new
          Models::Action.create :copy_files_to_module, Actions::CopyFilesToModuleDirectory.new
        elsif task.is_package_task?
          Models::Template.create :class, Templates::ClassPackage
          Models::Template.create :single, Templates::SinglePackage
        elsif task.is_user_task?
          Models::Template.create :class, Templates::ClassUser
          Models::Template.create :single, Templates::SingleUser
          Models::ImportFilter.create :passwd, Filter::Passwd.new
        end

        Models::ErrorMessage.preambel = "Sorry, but I can't fullfill your request. "
        Models::ErrorMessage.postscript = "\n\n=================\nPlease read the manual on \"http://github.com/maxmeyer/puppet_generator\" for more information on how to use the script."

        Models::ErrorMessage.create 1, "You entered an invalid source \"#{task.meta[:source]}\": it's not a directory or a file or you tell me to use a file/directory which does not exist or is empty. "
        Models::ErrorMessage.create 2, "You entered an invalid output channel: file or directory can be used."
        Models::ErrorMessage.create 3, "The source \"#{task.meta[:source]}\" you tell me to use does not contain any entries. Giving up."
        Models::ErrorMessage.create 4, "There's no import filter \"#{task.meta[:requested_import_filter]}\". Available import filters: #{Models::ImportFilter.all_names_as_string}."
        Models::ErrorMessage.create 5, "The input is no YAML valid for this use case."
        Models::ErrorMessage.create 6, "The input is no passwd file valid for this use case."
        Models::ErrorMessage.create 7, "There's no action \"#{task.meta[:requested_action]}\". Available actions: #{Models::Action.all_names_as_string}."

        task.logger.debug(self.class.name){ "available templates: " +  Models::Template.all_names_as_string }
        task.logger.debug(self.class.name){ "available filter: " +  Models::ImportFilter.all_names_as_string }
        task.logger.debug(self.class.name){ "available actions: " +  Models::Action.all_names_as_string }

        @app.call(task)
      end

      private

      def option_to_output(option)
        option.keys.join(", ")
      end

    end
  end
end
