module PuppetGenerator
  class InputFile
    attr_reader :lines

    def initialize( filename )
      @lines = File.open(filename).readlines.collect { |l| l.strip.chomp }
    end

  end
end
