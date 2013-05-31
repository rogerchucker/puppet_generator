module PuppetGenerator
  module Setup
    class User < Bare
      def initialize(options)
        super
      end

      def setup_environment
        DefaultErrorMessages.use
        DefaultImportFilter.use
        DefaultActions.use

        Models::Template.create :class, Templates::ClassUser
        Models::Template.create :single, Templates::SingleUser

        Models::ImportFilter.create :passwd, Filter::Passwd.new
      end
    end
  end
end
