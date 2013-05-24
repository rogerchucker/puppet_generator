module PuppetGenerator
  class InputDirectory
    attr_reader :entries

    def initialize(directory)
      @entries = Find.find(directory) { |path| FileTest.file? path }
    end

  end
end
