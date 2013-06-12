module PuppetGenerator
  class Create < Thor
    def self.exit_on_failure?
      true
    end

    class_option :module , type: :string, default: 'mymodule', desc: 'the module prefix in puppet class name'
    class_option :class , type: :string, default: 'myclass', desc: 'the class suffix in puppet class name'
    class_option :debug , type: :boolean, default: false, desc: 'enable debug logging and debugging libraries'
    class_option :silent , type: :boolean, default: false, desc: 'disable logging'

    @source_option = { type: :string, default: 'input.txt', desc: 'enter the source which should be used to generate the puppet output' }
    @import_filter_option = { type: :string, default: 'null', desc: 'make it possible to pipe structured data into command' }
    @destination_option = { type: :string, default: 'dir:out.d', desc: 'where should the information be stored. Valid input is "file|dir:<dest>" or "stdout"' }
    @action_option = { type: :array, default: [ :null ], desc: 'what action should be run after filtering the input: <action>( <action>)*' }
    @template_tagged_with_option = { type: :string, desc: 'use a template which is tagged with "<tag>(:<tag>)+"' }
    @export_filter_option = { type: :array, default: [ :null ], desc: 'modify the data before exporting it (to add some more value to it): <filter>( <filter>)*' }

    method_option :source , @source_option
    method_option :import_filter , @import_filter_option
    method_option :destination , @destination_option
    method_option :action , @action_option
    method_option :template_tagged_with, @template_tagged_with_option
    method_option :export_filter, @export_filter_option
    desc 'package', 'generate package definitions'
    def package
      PuppetGenerator::Api.new.generate_package_definition(options)
    end

    method_option :source , @source_option
    method_option :import_filter , @import_filter_option
    method_option :destination , @destination_option
    method_option :action , @action_option
    method_option :template_tagged_with, @template_tagged_with_option
    method_option :export_filter, @export_filter_option
    desc 'file', 'generate file definitions'
    def file
      PuppetGenerator::Api.new.generate_file_definition(options)
    end

    method_option :source , @source_option
    method_option :import_filter , @import_filter_option
    method_option :destination , @destination_option
    method_option :action , @action_option
    method_option :template_tagged_with, @template_tagged_with_option
    method_option :export_filter, @export_filter_option
    desc 'user', 'generate user definitions'
    def user
      PuppetGenerator::Api.new.generate_user_definition(options)
    end

    desc 'module', 'creates all files needed to build a module'
    def module
      PuppetGenerator::Api.new.generate_module(options)
    end

    method_option :source , @source_option
    method_option :import_filter , @import_filter_option
    method_option :destination , @destination_option
    method_option :action , @action_option
    method_option :template_tagged_with, @template_tagged_with_option
    method_option :export_filter, @export_filter_option
    desc 'role', 'generate role definitions'
    def role
      PuppetGenerator::Api.new.generate_role_definition(options)
    end

  end
end
