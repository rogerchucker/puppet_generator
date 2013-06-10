module PuppetGenerator
  module Actions
    class CopyFilesToModuleDirectory
      def run( task , data )
        src = data.collect { |e| e[:name] }
        binding.pry
        dst = File.join( task.meta[:module] , 'files')

        FileUtils.mkdir_p dst
        FileUtils.cp_r src , dst

        data.collect { |e| e[:source] = make_source( task.meta[:module] , e[:name]) ; e }
      rescue
        raise Exceptions::ErrorDuringCopyFiles
      end

      private

      def make_source(module_name, src)
        "puppet:///modules/#{module_name}/#{ src.sub( %r[^/], '' ) }"
      end
    end
  end
end
