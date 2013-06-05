module PuppetGenerator
  class Definition
    attr_reader :name, :text

    def initialize( name, text )
      @name = name
      @text = text
    end
  end
end
