module PuppetGenerator
  class FsFile
    
    attr_reader :path

    def initialize(path)
      @path = path
      @stats = File::Stat.new(path)
    end

    def mode
      "%o" % @stats.mode
    end

    def owner
      Etc.getpwuid(@stats.uid).name
    end

    def to_s
      @path
    end
    
  end
end
