module PuppetGenerator
  module Middleware
    class HandleErrors
      def initialize(app)
        @app = app
      end

      def call(t)
        @task = t

        PuppetGenerator.logger.debug(self.class.name){ "Waiting for errors to occure. ;-)" }

        begin
          @app.call(task)
        rescue PuppetGenerator::Exceptions::InvalidSource
          exit_with_error :invalid_source, source: task.meta[:source], command: task.meta[:command] 
        rescue PuppetGenerator::Exceptions::InvalidOutputChannel
          exit_with_error :invalid_output_channel
        rescue PuppetGenerator::Exceptions::EmptySource
          exit_with_error :empty_source, source: task.meta[:source]
        rescue PuppetGenerator::Exceptions::UnknownImportFilter
          exit_with_error :unknown_import_filter, requested_import_filter: task.meta[:requested_import_filter], 
                                                  available_import_filter: Models::ImportFilter.all_names_as_string
        rescue PuppetGenerator::Exceptions::InvalidYamlInput
          exit_with_error :invalid_yaml_input
        rescue PuppetGenerator::Exceptions::InvalidPasswdInput
          exit_with_error :invalid_passwd_input
        rescue PuppetGenerator::Exceptions::UnknownAction
          exit_with_error :unknown_action, requested_actions: task.meta[:requested_actions], 
                                           available_actions: Models::Action.all_names_as_string
        rescue PuppetGenerator::Exceptions::FilesystemError
          exit_with_error :filesystem_error, fs_object: task.meta[:source]
        rescue PuppetGenerator::Exceptions::WrongTemplateChosen
          exit_with_error :wrong_template_chosen, command: task.meta[:command], tags: task.meta[:template_tagged_with].to_a.join(", "), destination: task.meta[:destination] 
        rescue PuppetGenerator::Exceptions::InternalError => e
          exit_with_error :internal_error, exception_message: e.message
        rescue Exceptions::ErrorDuringCopyFiles => e
          exit_with_error :copy_error, exception_message: e.message
        rescue Interrupt
          exit_with_error :interrupt
        end
      end

      private 

      attr_reader :task

      def exit_with_error(name, parameter={})
        msg = Models::ErrorMessage.find(name)
        raise Exceptions::UnknownErrorMessage unless msg

        PuppetGenerator.logger.fatal msg.text(parameter)
        exit msg.code
      end

      def postscript
      end

      def option_to_output(option)
        option.keys.join(", ")
      end
    end
  end
end
