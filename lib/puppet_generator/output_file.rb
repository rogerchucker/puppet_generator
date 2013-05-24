module PuppetGenerator
  class OutputFile
    def initialize(filename, definitions, template_class, template_package)
      @filename = filename
      @definitions = definitions || []
      @template_class = template_class
      @template_package = template_package
    end

    def write
      File.open(@filename, "w") do |f|
       f.puts @template_class.render(@definitions, @template_package)
      end
    end

  end
end
