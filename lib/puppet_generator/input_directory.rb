module PuppetGenerator
  class InputDirectory
    attr_reader :entries

    def initialize(directory)
      @entries = []
      Find.find(directory) { |path| @entries << Pathname.new( path ) }
    end

  end
end
