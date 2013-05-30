module PuppetGenerator
  module Setup
    class File < Default

      def initialize(options)
        super
      end

      def setup_environment
        super

        Models::Template.create :class, Templates::ClassFile
        Models::Template.create :single, Templates::SingleFile
        Models::ImportFilter.create :filesystem_attributes, Filter::FilesystemAttributes.new
        Models::Action.create :copy_files_to_module, Actions::CopyFilesToModuleDirectory.new
      end

    end
  end
end
