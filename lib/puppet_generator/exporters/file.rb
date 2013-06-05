module PuppetGenerator
  module Exporters
    class File

      def write(filename, definitions)
        ::File.open(filename, "w") do |f|
          f.puts content
            definitions.first.text
        end
      end

      def writes_to?(destination)
        /^file:/ === destination
      end

    end
  end
end
