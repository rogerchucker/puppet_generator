module PuppetGenerator
  class InputDirectory
    attr_reader :entries

    def initialize( directory , generator)
      @directory = directory
      @entries = []

      Find.find( directory) { |path| entries << generator.new( path ) }
    end

  end
end
