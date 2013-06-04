module PuppetGenerator
  module Importers
    class Stdin
      attr_reader :lines

      def initialize( input=$stdin )
        @input = input
      end

      def read
        @input.readlines.collect { |l| l.strip.chomp }
      end

    end
  end
end
