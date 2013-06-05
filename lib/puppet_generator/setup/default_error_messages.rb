module PuppetGenerator
  module Setup
    module DefaultErrorMessages
      def self.use
        Models::ErrorMessage.enable :invalid_source
        Models::ErrorMessage.enable :invalid_output_channel
        Models::ErrorMessage.enable :empty_source
        Models::ErrorMessage.enable :unknown_import_filter
        Models::ErrorMessage.enable :invalid_yaml_input
        Models::ErrorMessage.enable :invalid_passwd_input
        Models::ErrorMessage.enable :unknown_action
        Models::ErrorMessage.enable :internal_error
      end
    end
  end
end

