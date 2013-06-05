module PuppetGenerator
  class PuppetFile
    attr_reader :path, :module_name, :class_name, :owner, :mode, :source, :type

    def initialize(entry, module_name, class_name)
      @path = entry[:name]
      @module_name = module_name
      @class_name = class_name

      @owner = entry[:owner]
      @mode = entry[:mode]
      @type = entry.fetch( :type, 'file' )
      @source = entry[:source]
    end

    def name
      File.basename(path)
    end
  end
end
