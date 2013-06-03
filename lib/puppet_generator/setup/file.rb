module PuppetGenerator
  module Setup
    class File < Bare

      def initialize(options)
        super
      end

      def setup_environment
        Models::Template.init
        Models::ImportFilter.init

        DefaultErrorMessages.use
        DefaultImportFilter.use
        DefaultActions.use

        Models::Action.create :copy_files_to_module, Actions::CopyFilesToModuleDirectory.new
        Models::Template.find_all(:file).collect { |t| t.activate }
        Models::ImportFilter.enable :filesystem_attributes
      end
    end
  end
end
