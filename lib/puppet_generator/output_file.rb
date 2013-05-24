module PuppetGenerator
  class OutputFile
    def initialize(directory, definitions)
      @directory = directory
      @definitions = definitions || []
    end

    def create_output_directory
      Dir.mkdir @directory unless Dir.exists? @directory
    end

    def create_output_files
      @definitions.each do |d| 
        filename = File.join( @directory, "#{d.name}.pp" )

        File.open(filename, "w") do |f|
          f.puts d.to_s
        end
      end
    end

    def write
      #output = @definitions.inject( [] ) { |strings, definition| strings << definition.to_s }
      #File.open(@filename, "w") do |f|
      # f.puts output.join("\n")
      #end

      create_output_directory
      create_output_files
    end

  end
end
