module PuppetGenerator
  module ExportFilters
    class FilesystemAttributes
      def convert(objects, task)

        objects.collect do |o|
          path = o[:name]

          if File.exists? path
            fs_object_info = stats(path)

            o.merge!( { 
              type: type(path),
              owner: owner(fs_object_info),
              mode: mode(fs_object_info),
            } )
          end

          o
        end

      end

      private

      def stats(path)
        File::Stat.new(path) 
      end

      def mode(fs_object_info)
        "%o" % fs_object_info.mode
      end

      def owner(fs_object_info)
        Etc.getpwuid(fs_object_info.uid).name
      end

      def type(path)
        if file?(path)
          return 'file'
        elsif directory?(path)
          return 'directory'
        else
          return 'file'
        end
      end

      def file?(path)
        FileTest.file? path
      end

      def directory?(path)
        FileTest.directory? path
      end
    end
  end
end
