module PuppetGenerator
  module Filter
    class FilesystemAttributes
      def convert(lines)
        lines.collect do |line|

          @path = line
          @stats = File::Stat.new(line)

          { 
            name: line,
            type: type,
            owner: owner,
            mode: mode,
          }
        end
      end

      private

      def mode
        "%o" % @stats.mode
      end

      def owner
        Etc.getpwuid(@stats.uid).name
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

      def file?
        FileTest.file? @path
      end

      def directory?
        FileTest.directory? @path
      end
    end
  end
end
