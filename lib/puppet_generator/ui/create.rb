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
        binding.pry
        PuppetGenerator::Api::CreateDefinition.new(options).package
      end

      method_option :source,               Ui::CommandlineParserHelper.subcommand_options[:source]
      method_option :import_filter,        Ui::CommandlineParserHelper.subcommand_options[:import_filter]
      method_option :destination,          Ui::CommandlineParserHelper.subcommand_options[:destination]
      method_option :action,               Ui::CommandlineParserHelper.subcommand_options[:action]
      method_option :template_tagged_with, Ui::CommandlineParserHelper.subcommand_options[:template_tagged_with]
      method_option :export_filter,        Ui::CommandlineParserHelper.subcommand_options[:export_filter]
      desc 'file', 'generate file definitions'
      def file
        PuppetGenerator::Api::CreateDefinition.new(options).file
      end

      method_option :source,               Ui::CommandlineParserHelper.subcommand_options[:source]
      method_option :import_filter,        Ui::CommandlineParserHelper.subcommand_options[:import_filter]
      method_option :destination,          Ui::CommandlineParserHelper.subcommand_options[:destination]
      method_option :action,               Ui::CommandlineParserHelper.subcommand_options[:action]
      method_option :template_tagged_with, Ui::CommandlineParserHelper.subcommand_options[:template_tagged_with]
      method_option :export_filter,        Ui::CommandlineParserHelper.subcommand_options[:export_filter]
      desc 'user', 'generate user definitions'
      def user
        PuppetGenerator::Api::CreateDefinition.new(options).user
      end

      desc 'module', 'creates all files needed to build a module'
      def module
        PuppetGenerator::Api::CreateModule.new(options).module
      end

      method_option :source,               Ui::CommandlineParserHelper.subcommand_options[:source]
      method_option :import_filter,        Ui::CommandlineParserHelper.subcommand_options[:import_filter]
      method_option :destination,          Ui::CommandlineParserHelper.subcommand_options[:destination]
      method_option :action,               Ui::CommandlineParserHelper.subcommand_options[:action]
      method_option :template_tagged_with, Ui::CommandlineParserHelper.subcommand_options[:template_tagged_with]
      method_option :export_filter,        Ui::CommandlineParserHelper.subcommand_options[:export_filter]
      desc 'role', 'generate role definitions'
      def role
        PuppetGenerator::Api::CreateDefinition.new(options).role
      end

    end
  end
end
