module PuppetGenerator
  module Models
    class ErrorMessage < Base

      attr_accessor :preambel, :postscript, :code
      class << self
        attr_accessor :preambel, :postscript

        def reset
          self.clear

          self.preambel = nil
          self.postscript = nil
        end

        def init
          Models::ErrorMessage.preambel = "Sorry, but I can't fullfill your request. "
          Models::ErrorMessage.postscript = "\n\n=================\nPlease read the manual on \"http://github.com/maxmeyer/puppet_generator\" for more information on how to use the script."

          Models::ErrorMessage.create :invalid_source,         1, "You entered an invalid source \"<%= @source %>\": it's not possible to use this source with \"<%= @command %>."
          Models::ErrorMessage.create :invalid_output_channel, 2, "You entered an invalid output channel: file or directory can be used."
          Models::ErrorMessage.create :empty_source,           3, "The source \"<%= @source %>\" you tell me to use does not contain any entries. Giving up."
          Models::ErrorMessage.create :unknown_import_filter,  4, "There's no import filter \"<%= @requested_import_filter %>\". Available import filters: <%= @available_import_filter %>."
          Models::ErrorMessage.create :invalid_yaml_input,     5, "The input is no YAML valid for this use case."
          Models::ErrorMessage.create :invalid_passwd_input,   6, "The input is no passwd file valid for this use case."
          Models::ErrorMessage.create :unknown_action,         7, "There's no action \"<%= @requested_action %>\". Available actions: <%= @available_actions %>."
          Models::ErrorMessage.create :filesystem_error,       8, "The file/directory \"<%= @fs_object %>\" does not exist."
        end
      end

      def initialize(name, code, template)
        super(name)

        @code = code
        @template = template
      end

      def text(options={})
        result = []
        result << ( preambel ? preambel : self.class.preambel )
        result << Erubis::Eruby.new(@template).evaluate(options)
        result << ( postscript ? postscript : self.class.postscript )

        result.join
      end
    end
  end
end
