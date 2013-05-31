module PuppetGenerator
  module Setup
    class Default < Bare

      def initialize(options)
        super
      end

      def setup_environment
        super

        Models::Action.create :null, Actions::Null.new
        Models::ImportFilter.create :null, Filter::Null.new
        Models::ImportFilter.create :yaml, Filter::Yaml.new
      end

    end
  end
end
