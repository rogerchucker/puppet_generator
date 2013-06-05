module PuppetGenerator
  class OutputDirectory
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
          f.puts d.text
        end
      end
    end

    def write
      create_output_directory
      create_output_files
    end

  end
end
