module PuppetGenerator
  module Exporters
    class Stdout

      def write( output=$stdout , definitions=[] )
        output = definitions.inject( [] ) { |strings, definition| strings << definition.text }
        printf "%s", output.join("\n")
      end

      def writes_to?(destination)
        /^stdout/ === destination
      end

    end
  end
end
