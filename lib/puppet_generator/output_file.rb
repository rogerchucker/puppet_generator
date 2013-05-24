module PuppetGenerator
  class OutputFile
    def initialize(filename, definitions)
      @filename = filename
      @definitions = definitions || []
    end

    def write
      output = @definitions.inject( [] ) { |strings, definition| strings << definition.to_s }

      File.open(@filename, "w") do |f|
       f.puts output.join("\n")
      end
    end

  end
end
