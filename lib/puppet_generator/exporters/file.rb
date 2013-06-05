module PuppetGenerator
  module Exporters
    class File

      def write(filename, definitions)
        ::File.open(filename, "w") do |f|
          definitions.each { |d| f.puts d.text }
        end
      end

      def writes_to?(destination)
        /^file:/ === destination
      end

    end
  end
end
