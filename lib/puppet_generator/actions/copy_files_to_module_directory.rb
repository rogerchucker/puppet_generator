module PuppetGenerator
  module Actions
    class CopyFilesToModuleDirectory
      def run(task)
        src = task.body.collect { |e| e[:name] }
        dst = File.join(task.meta[:module], 'files')

        FileUtils.cp_r src , dst
      rescue
        raise Exceptions::ErrorDuringCopyFiles
      end
    end
  end
end
