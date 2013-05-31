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

        Models::Template.create :class, Templates::ClassFile
        Models::Template.create :single, Templates::SingleFile
        Models::Action.create :copy_files_to_module, Actions::CopyFilesToModuleDirectory.new
        Models::ImportFilter.create :filesystem_attributes, Filter::FilesystemAttributes.new
      end
    end
  end
end
