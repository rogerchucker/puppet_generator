module PuppetGenerator
  class OutputStdOut
    def initialize( definitions )
      @definitions = definitions || []
    end

    def write
      output = @definitions.inject( [] ) { |strings, definition| strings << definition.text }
      printf "%s", output.join("\n")
    end

  end
end
