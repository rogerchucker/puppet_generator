module PuppetGenerator
  module Creators
    class UserEntry

      attr_reader :name

      def initialize(name)
        @name = name
      end

      def to_s
        @path
      end

    end
  end
end
