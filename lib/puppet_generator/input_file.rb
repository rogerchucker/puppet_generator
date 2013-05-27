module PuppetGenerator
  class InputFile
    attr_reader :entries

    def initialize(filename, generator)
      @entries = File.open(filename).readlines.collect { |e| generator.new( e.chomp.strip ) }
    end

  end
end
