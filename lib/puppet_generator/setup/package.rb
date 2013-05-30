module PuppetGenerator
  module Setup
    class Package < Default

      def initialize(options)
        super
      end

      def setup_environment
        super

        Models::Template.create :class, Templates::ClassPackage
        Models::Template.create :single, Templates::SinglePackage
      end
    end
  end
end
