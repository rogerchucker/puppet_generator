module PuppetGenerator
  class InputDirectory
    attr_reader :entries

    def initialize( directory )
      @directory = directory
      @entries = []

      Find.find( directory) { |path| entries << FsFile.new( path ) }
    end

  end
end
