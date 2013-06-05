module PuppetGenerator
  module Actions
    class CopyFilesToModuleDirectory
      def run(task)
        src = task.body.collect { |e| e[:name] }
        dst = File.join(task.meta[:module], 'files')

        FileUtils.cp_r src , dst

        task.body.collect { |e| e[:source] = make_source(task.meta[:module], e[:name]) ; e}
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
