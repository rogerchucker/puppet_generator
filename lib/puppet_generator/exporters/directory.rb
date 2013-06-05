module PuppetGenerator
  module Exporters
    class Directory

      def write(directory, definitions=[])
        ::Dir.mkdir directory unless ::Dir.exists? directory

        definitions.each do |d| 
          filename = ::File.join( directory, "#{d.name}.pp" )

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
