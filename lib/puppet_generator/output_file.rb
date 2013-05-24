module PuppetGenerator
  class OutputFile
    def initialize(filename, template )
      @filename = filename
      @template = template
    end

    def write
      File.open(@filename, "w") do |f|
       f.puts @template.render
      end
    end

  end
end
