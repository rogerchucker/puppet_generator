module PuppetGenerator
  module ExportFilters
    class CopyFilesToModuleDirectory
      def convert( objects, task )
        src = objects.collect { |e| e[:name] }
        dst = File.join( task.meta[:module] , 'files')

        FileUtils.mkdir_p dst
        FileUtils.cp_r src , dst

        data.collect { |e| e[:source] = make_source( task.meta[:module] , e[:name]) ; e }
      rescue Exception => e
        raise Exceptions::ErrorDuringCopyFiles, e.message
      end

      private

      def make_source(module_name, src)
        "puppet:///modules/#{module_name}/#{ src.sub( %r[^/], '' ) }"
      end
    end
  end
end
