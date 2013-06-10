module PuppetGenerator
  module Actions
    class CopyFilesToModuleDirectory
      def run( module_name , data )
        src = data.collect { |e| e[:name] }
        dst = File.join( module_name , 'files')

        FileUtils.mkdir_p dst
        FileUtils.cp_r src , dst

        data.collect { |e| e[:source] = make_source( module_name , e[:name]) ; e }
      rescue
        raise Exceptions::ErrorDuringCopyFiles
      end

      private

      def make_source(module_name, src)
        "puppet:///modules/#{module_name}/#{src}"
      end
    end
  end
end
