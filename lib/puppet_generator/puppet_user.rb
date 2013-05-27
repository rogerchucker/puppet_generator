module PuppetGenerator
  class PuppetUser
    attr_reader :name, :module_name, :class_name

    def initialize(entry, module_name, class_name)
      @name = entry.name
      @module_name = module_name
      @class_name = class_name

      @shell = entry.shell if entry.respond_to? :shell
      @home_dir = entry.home_dir if entry.respond_to? :home_dir
    end

  end
end
