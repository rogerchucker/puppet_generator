module PuppetGenerator
  module ExportFilters
    class BuildRoleIncludesForDirectory

      include PuppetHelper

      def convert(objects, meta)

        objects.collect do |o|
          path = o[:name]

          next unless directory? path

          result = {
            name: path,
            includes: includes(path),
          }
        end.compact

      end

      private

      def includes(path)
        Dir.glob( File.join( path, '*.pp' ) ).collect { |f| File.basename( f, '.pp') }.sort
      rescue
        PuppetGenerator.logger.warn(self.class.name) { "Directory \"#{o[:name]}\" does not exist. There's no chance to get subentries for it. Therefor I use the name only and do not generate \"include\"-instructions." }
      end

      def directory?(path)
        FileTest.directory? path
      end
    end
  end
end
