module PuppetGenerator
  module Setup
    class Default

      def initialize(options)
        @task = Task.new(options)
      end

      def setup_environment
        Models::ImportFilter.create :plain, Filter::Plain.new
        Models::ImportFilter.create :yaml, Filter::Yaml.new

        Models::Action.create :none, Actions::None.new

        error_messages
      end

      def error_messages
        Models::ErrorMessage.preambel = "Sorry, but I can't fullfill your request. "
        Models::ErrorMessage.postscript = "\n\n=================\nPlease read the manual on \"http://github.com/maxmeyer/puppet_generator\" for more information on how to use the script."

        Models::ErrorMessage.create 1, "You entered an invalid source \"<%= @source %>\": it's not a directory or a file or you tell me to use a file/directory which does not exist or is empty. "
        Models::ErrorMessage.create 2, "You entered an invalid output channel: file or directory can be used."
        Models::ErrorMessage.create 3, "The source \"<%= @source %>\" you tell me to use does not contain any entries. Giving up."
        Models::ErrorMessage.create 4, "There's no import filter \"<%= @requested_import_filter %>\". Available import filters: <%= @available_import_filter %>."
        Models::ErrorMessage.create 5, "The input is no YAML valid for this use case."
        Models::ErrorMessage.create 6, "The input is no passwd file valid for this use case."
        Models::ErrorMessage.create 7, "There's no action \"<%= @requested_action %>\". Available actions: <%= @available_actions %>."
      end

      def create_task
        @task
      end

    end
  end
end
