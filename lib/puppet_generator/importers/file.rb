module PuppetGenerator
  module Importers
    class File

      def initialize( filename='' )
        @filename = filename
      end

      def read
        @lines = ::File.open(@filename).readlines.collect { |l| l.chomp }
      end

    end
  end
end
