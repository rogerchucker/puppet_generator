module PuppetGenerator
  class OutputStdOut
    def initialize( definitions )
      @definitions = definitions || []
    end

    def write
      output = @definitions.inject( [] ) { |strings, definition| strings << definition.to_s }
      printf "%s", output.join("\n")
    end

  end
end
