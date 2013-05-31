module PuppetGenerator
  module Setup
    class Package < Bare


      def initialize(options)
        super
      end

      def setup_environment
        DefaultErrorMessages.use
        DefaultImportFilter.use
        DefaultActions.use

        Models::Template.create :class, Templates::ClassPackage
        Models::Template.create :single, Templates::SinglePackage
      end
    end
  end
end
