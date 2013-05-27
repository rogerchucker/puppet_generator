module PuppetGenerator
  class PuppetFile
    attr_reader :path, :module_name, :class_name, :owner, :mode, :source

    def initialize(path, module_name, class_name, opts={})
      options = {
        owner: owner, 
        mode: mode, 
        source: source, 
      }.merge opts

      @path = path
      @module_name = module_name
      @class_name = class_name
      @owner = options[:owner]
      @mode = options[:mode]
      @source = options[:source]
    end

    def name
      File.basename(path)
    end
  end
end
