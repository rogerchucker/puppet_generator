module PuppetGenerator
  class InputStdIn
    attr_reader :entries

    def initialize
      @entries = $stdin.readlines
    end

  end
end
