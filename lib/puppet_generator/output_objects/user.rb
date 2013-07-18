module PuppetGenerator
  module OutputObjects
    class User

      include PuppetHelper

      attr_reader :name, :userid, :homedir, :groupid, :shell, :provider, :module_name, :class_name

      def initialize(entry)
        @name = entry[:name]
        @module_name = entry[:module]
        @class_name = entry[:class]

        @userid = entry[:userid]
        @groupid = entry[:groupid]
        @shell = entry[:shell]
        @homedir = entry[:homedir]
        @provider = entry[:provider]
      end

      def suggested_file_name
        puppet_manifest_path( name )
      end

    end
  end
end
