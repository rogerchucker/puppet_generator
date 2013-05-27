module PuppetGenerator
  class PuppetFile
    attr_reader :name, :module_name, :class_name, :owner, :mode, :source

    def initialize(name, module_name, class_name, opts={})
      options = {
        owner: owner, 
        mode: mode, 
        source: source, 
      }.merge opts

      @name = name.strip
      @module_name = module_name
      @class_name = class_name
      @owner = options[:owner]
      @mode = options[:mode]
      @source = options[:source]
    end
  end
end
