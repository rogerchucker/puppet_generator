module PuppetGenerator
  class InputStdIn
    attr_reader :entries

    def initialize( generator )
      @entries = $stdin.readlines.collect { |e| generator.new(e.strip) }
    end

  end
end
