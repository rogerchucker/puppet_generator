module PuppetGenerator
  class OutputFile
    def initialize( filename, definitions )
      @filename = filename
      @definitions = definitions
    end

    def write
      File.open(@filename, "w") do |f|
       f.puts @definitions.first.text
      end
    end

  end
end
