module PuppetGenerator
  module Importers
    class File

      def read(filename)
        ::File.open(filename).readlines.collect { |l| l.chomp }
      rescue Exception => e
        raise Exceptions::FileDoesNotExist, e.message
      end

      def reads_from?(source)
        FileTest.file? source
      end

    end
  end
end
