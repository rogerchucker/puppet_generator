module PuppetGenerator
  module Importers
    class Directory
      attr_reader :lines

      def initialize( directory='' )
        @directory = directory
        @lines = []
      end

      def read
        ::Find.find( directory) { |path| @lines << path }

        @lines
      end

      def reads_from?(source)
        FileTest.directory? source
      end

    end
  end
end
