module PuppetGenerator
  class InputStdIn
    attr_reader :entries

    def initialize
      @entries = $stdin.readlines.collect { |e| e.strip }
    end

  end
end
