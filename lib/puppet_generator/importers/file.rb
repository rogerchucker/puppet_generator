module PuppetGenerator
  module Importers
    class File

      def initialize( filename='' )
        @filename = filename
      end

      def read
        @lines = ::File.open(@filename).readlines.collect { |l| l.chomp }
      end

      def reads_from?(source)
        FileTest.file? source
      end

    end
  end
end
