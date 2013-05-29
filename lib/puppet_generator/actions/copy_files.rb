module PuppetGenerator
  module Actions
    class CopyFiles
      def run(files,module_path)
        binding.pry
        #FileUtils.cp_r files, module_path
      rescue
        raise Exceptions::ErrorDuringCopyFiles
      end
    end
  end
end
