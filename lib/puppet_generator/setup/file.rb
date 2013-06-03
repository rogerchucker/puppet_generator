module PuppetGenerator
  module Setup
    class File < Bare

      def initialize(options)
        super
      end

      def setup_environment
        DefaultErrorMessages.use
        DefaultImportFilter.use
        DefaultActions.use

        Models::Action.enable :copy_files_to_module
        Models::Template.find_all(:file).collect { |t| t.enable }
        Models::ImportFilter.enable :filesystem_attributes
      end
    end
  end
end
