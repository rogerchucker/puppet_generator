module PuppetGenerator
  module ExportFilters
    class FilesystemAttributes
      def convert(objects)
        objects.collect do |o|

          if File.exists? o
            fs_object_info = stats(o)

            o.merge( { 
              type: type(object),
              owner: owner,
              mode: mode,
            } )
          else
            o
          end
        end
      end

      private

      def stats(o)
        File::Stat.new(o) 
      end

      def mode(o)
        "%o" % o.mode
      end

      def owner(o)
        Etc.getpwuid(o.uid).name
      end

      def type(o)
        if file?(o)
          return 'file'
        elsif directory?(o)
          return 'directory'
        else
          return 'file'
        end
      end

      def file?(o)
        FileTest.file? o
      end

      def directory?(o)
        FileTest.directory? o
      end
    end
  end
end
