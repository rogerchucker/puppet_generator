module PuppetGenerator
  module Importers
    class Directory
      attr_reader :lines

      def read( directory )
        lines = []
        ::Find.find( directory) { |path| lines << path }

        lines
      rescue Exception => e
        raise Exceptions::DirectoryDoesNotExist, e.message
      end

      def reads_from?(source)
        raise Exceptions::DirectoryDoesNotExist unless FileTest.exists? source

        FileTest.directory? source
      end

    end
  end
end
