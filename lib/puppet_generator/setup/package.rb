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

        Models::Template.find_all(:package).collect { |t| t.enable }
      end
    end
  end
end
