module PuppetGenerator
  module Importers
    class StdIn
      attr_reader :lines

      def initialize
        @lines = $stdin.readlines.collect { |l| l.strip.chomp }
      end

    end
  end
end
