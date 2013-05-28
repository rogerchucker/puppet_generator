module PuppetGenerator
  class InputStdIn
    attr_reader :lines

    def initialize
      @lines = $stdin.readlines.collect { |l| l.strip.chomp }
    end

  end
end
