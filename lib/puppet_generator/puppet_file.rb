module PuppetGenerator
  class PuppetFile
    attr_reader :path, :module_name, :class_name, :owner, :mode, :source, :type

    def initialize(entry, module_name, class_name)
      @path = entry.to_s
      @module_name = module_name
      @class_name = class_name

      @owner = entry.owner if entry.respond_to? :owner
      @mode = entry.mode if entry.respond_to? :mode
      @type = entry.type if entry.respond_to? :type
    end

    def name
      File.basename(path)
    end
  end
end
