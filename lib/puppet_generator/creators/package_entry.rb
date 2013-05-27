module PuppetGenerator
  module Creators
    class PackageEntry

      attr_reader :name

      def initialize(name)
        @name = name
      end

      def to_s
        @name
      end

    end
  end
end
