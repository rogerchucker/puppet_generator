module PuppetGenerator
  module PuppetObjects
    class User
      attr_reader :name, :userid, :homedir, :groupid, :shell, :provider, :module_name, :class_name

      def initialize(entry, module_name, class_name)
        @name = entry[:name]
        @module_name = module_name
        @class_name = class_name

        @userid = entry[:userid]
        @groupid = entry[:groupid]
        @shell = entry[:shell]
        @homedir = entry[:homedir]
        @provider = entry[:provider]
      end

    end
  end
end
