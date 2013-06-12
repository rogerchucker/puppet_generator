module PuppetGenerator
  module Ui
    module CommandlineParserHelper

      @runner_options = {}
      @runner_options[:module] = { type: :string, default: 'mymodule', desc: 'the module prefix in puppet class name' }
      @runner_options[:class] =  { type: :string, default: 'myclass', desc: 'the class suffix in puppet class name' }
      @runner_options[:debug] =  { type: :boolean, default: false, desc: 'enable debug logging and debugging libraries' }
      @runner_options[:silent] = { type: :boolean, default: false, desc: 'disable logging' }

      @subcommand_options = {}
      @subcommand_options[:source] =               { type: :string, default: 'input.txt', desc: 'enter the source which should be used to generate the puppet output' }
      @subcommand_options[:import_filter] =        { type: :string, default: 'null', desc: 'make it possible to pipe structured data into command' }
      @subcommand_options[:destination] =          { type: :string, default: 'dir:out.d', desc: 'where should the information be stored. Valid input is "file|dir:<dest>" or "stdout"' }
      @subcommand_options[:action] =               { type: :array, default: [ :null ], desc: 'what action should be run after filtering the input: <action>( <action>)*' }
      @subcommand_options[:template_tagged_with] = { type: :string, desc: 'use a template which is tagged with "<tag>(:<tag>)+"' }
      @subcommand_options[:export_filter] =        { type: :array, default: [ :null ], desc: 'modify the data before exporting it (to add some more value to it): <filter>( <filter>)*' }

      class << self
        attr_reader :runner_options
        attr_reader :subcommand_options
      end

      def self.pretty_subcommands(cmds)
        cmds.keys.join(', ')
      end


    end
  end
end
