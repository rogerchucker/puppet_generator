module PuppetGenerator
  class Tasks < Thor
    @source_option = { type: :string, default: 'input.txt', desc: 'enter the source which should be used to generate the puppet output' }
    @destination_option = { type: :string, default: 'dir:out.d', desc: 'where should the information be stored. Valid input is "file|dir:<dest>" or "stdout"' }

    def self.exit_on_failure?
      true
    end

    method_option :source , @source_option
    method_option :destination , @destination_option
    desc "create_roles_in_directory", "Search directory for directories and generate role puppet definition for found .pp-files"
    def create_roles_in_directory
      PuppetGenerator::Runner.start( %W[create role --export-filter build_role_includes_for_directory --source #{options[:source]} --destination #{options[:destination]}] )
    end
  end
end
