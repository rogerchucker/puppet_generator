module PuppetGenerator
  module Importers
    class File
      attr_reader :lines

      def initialize( filename )
        @lines = ::File.open(filename).readlines.collect { |l| l.chomp }
      end

    end
  end
end
