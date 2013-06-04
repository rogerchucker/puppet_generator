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

      def reads_from?(source)
        source == 'stdin'
      end

    end
  end
end
