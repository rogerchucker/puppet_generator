module PuppetGenerator
  module Setup
    class Default < Bare

      def initialize(options)
        super
      end

      def setup_environment
        super

        Models::Action.create :none, Actions::None.new
        Models::ImportFilter.create :plain, Filter::Plain.new
        Models::ImportFilter.create :yaml, Filter::Yaml.new
      end

    end
  end
end
