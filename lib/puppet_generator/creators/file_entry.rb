module PuppetGenerator
  module Creators
    class FileEntry

      attr_reader :path

      def initialize(path)
        @path = path
        @stats = File::Stat.new(path)
      end

      def mode
        "%o" % @stats.mode
      end

      def owner
        Etc.getpwuid(@stats.uid).name
      end

      def to_s
        @path
      end

      def type
        if file?
          return 'file'
        elsif directory?
          return 'directory'
        else
          return 'file'
        end
      end

      private

      def file?
        FileTest.file? @path
      end

      def directory?
        FileTest.directory? @path
      end

    end
  end
end
