module PuppetGenerator
  module Exporters
    class Directory

      def write(directory, definitions=[])

        definitions.each do |d| 
          filename = ::File.join( directory, "#{d.file_name}" )
          dir = ::File.dirname filename

          ::Dir.mkdir dir unless ::Dir.exists? dir

          ::File.open(filename, "w") do |f|
            f.puts d.text
          end
        end
      end

      def writes_to?(destination)
        /^(?:dir|directory):/ === destination
      end

    end
  end
end
