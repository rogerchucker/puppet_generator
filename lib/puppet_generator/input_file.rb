module PuppetGenerator
  class InputFile
    def initialize(filename, generator)
      @entries = File.open(filename).readlines
    end

    def entries
      @entries.collect { |e| generator.new( e.chomp.strip ) }
    end

  end
end
