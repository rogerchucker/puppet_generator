module PuppetGenerator
  module Middleware
    class CreateModuleDirectories
      def initialize(app)
        @app = app
      end

      def call(task)
        module_name = task.meta[:module]
        module_dirs = %w[ manifests files ].collect { |d| File.join(module_name, d) }
        module_file =  File.join(module_name, 'init.pp')

        task.logger.info(self.class.name) { "Create the module directory for module \"#{module_name}\" at \"#{Dir.pwd}\"." }

        mkdir module_name
        mkdir module_dirs
        mkfile module_file, <<-EOF
class #{module_name} {

}
        EOF

      end

      private

      def mkdir(*dirs)
        FileUtils.mkdir_p( dirs.flatten.collect { |d| File.join(root_path, d ) } )
      end

      def mkfile(file, content)
        File.open(file, "w") do |f|
          f.write content
        end
      end

      def root_path
        Dir.pwd
      end
    end
  end
end
