module PuppetGenerator
  module Ui
    class Create < Thor
      extend ThorHelper

      method_option :source,               Ui::CommandlineParserHelper.subcommand_options[:source]
      method_option :import_filter,        Ui::CommandlineParserHelper.subcommand_options[:import_filter]
      method_option :destination,          Ui::CommandlineParserHelper.subcommand_options[:destination]
      method_option :action,               Ui::CommandlineParserHelper.subcommand_options[:action]
      method_option :template_tagged_with, Ui::CommandlineParserHelper.subcommand_options[:template_tagged_with]
      method_option :export_filter,        Ui::CommandlineParserHelper.subcommand_options[:export_filter]
      desc 'package', 'generate package definitions'
      def package
        PuppetGenerator::Api::CreateDefinition.new(
          options.merge( { 'command_chain' => [ :create, :package ] } ) 
        ).run
      end

      method_option :source,               Ui::CommandlineParserHelper.subcommand_options[:source]
      method_option :import_filter,        Ui::CommandlineParserHelper.subcommand_options[:import_filter]
      method_option :destination,          Ui::CommandlineParserHelper.subcommand_options[:destination]
      method_option :action,               Ui::CommandlineParserHelper.subcommand_options[:action]
      method_option :template_tagged_with, Ui::CommandlineParserHelper.subcommand_options[:template_tagged_with]
      method_option :export_filter,        Ui::CommandlineParserHelper.subcommand_options[:export_filter]
      desc 'file', 'generate file definitions'
      def file
        PuppetGenerator::Api::CreateDefinition.new(
          options.merge( { 'command_chain' => [ :create, :file ] } ) 
        ).run
      end

      method_option :source,               Ui::CommandlineParserHelper.subcommand_options[:source]
      method_option :import_filter,        Ui::CommandlineParserHelper.subcommand_options[:import_filter]
      method_option :destination,          Ui::CommandlineParserHelper.subcommand_options[:destination]
      method_option :action,               Ui::CommandlineParserHelper.subcommand_options[:action]
      method_option :template_tagged_with, Ui::CommandlineParserHelper.subcommand_options[:template_tagged_with]
      method_option :export_filter,        Ui::CommandlineParserHelper.subcommand_options[:export_filter]
      desc 'user', 'generate user definitions'
      def user
        PuppetGenerator::Api::CreateDefinition.new(
          options.merge( { 'command_chain' => [ :create, :user ] } ) 
        ).run
      end

      desc 'module', 'creates all files needed to build a module'
      def module
        PuppetGenerator::Api::CreateModule.new(
          options.merge( { 'command_chain' => [ :create, :module ] } ) 
        ).run
      end

      method_option :source,               Ui::CommandlineParserHelper.subcommand_options[:source]
      method_option :import_filter,        Ui::CommandlineParserHelper.subcommand_options[:import_filter]
      method_option :destination,          Ui::CommandlineParserHelper.subcommand_options[:destination]
      method_option :action,               Ui::CommandlineParserHelper.subcommand_options[:action]
      method_option :template_tagged_with, Ui::CommandlineParserHelper.subcommand_options[:template_tagged_with]
      method_option :export_filter,        Ui::CommandlineParserHelper.subcommand_options[:export_filter]
      desc 'role', 'generate role definitions'
      def role
        PuppetGenerator::Api::CreateDefinition.new(
          options.merge( { 'command_chain' => [ :create, :role ] } ) 
        ).run
      end

    end
  end
end
