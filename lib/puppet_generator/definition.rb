module PuppetGenerator
  class Definition
    attr_reader :file_name, :text

    def initialize( file_name, text )
      @file_name = file_name
      @text = text
    end
  end
end
