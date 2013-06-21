module PuppetGenerator
  module Ui
    class Create < Thor
      def self.exit_on_failure?
        true
      end

      method_option :source,               Ui::CommandlineParserHelper.subcommand_options[:source]
      method_option :import_filter,        Ui::CommandlineParserHelper.subcommand_options[:import_filter]
      method_option :destination,          Ui::CommandlineParserHelper.subcommand_options[:destination]
      method_option :action,               Ui::CommandlineParserHelper.subcommand_options[:action]
      method_option :template_tagged_with, Ui::CommandlineParserHelper.subcommand_options[:template_tagged_with]
      method_option :export_filter,        Ui::CommandlineParserHelper.subcommand_options[:export_filter]
      desc 'package', 'generate package definitions'
      def package
        PuppetGenerator::Api::Create.new(options).package_definition
      end

      method_option :source,               Ui::CommandlineParserHelper.subcommand_options[:source]
      method_option :import_filter,        Ui::CommandlineParserHelper.subcommand_options[:import_filter]
      method_option :destination,          Ui::CommandlineParserHelper.subcommand_options[:destination]
      method_option :action,               Ui::CommandlineParserHelper.subcommand_options[:action]
      method_option :template_tagged_with, Ui::CommandlineParserHelper.subcommand_options[:template_tagged_with]
      method_option :export_filter,        Ui::CommandlineParserHelper.subcommand_options[:export_filter]
      desc 'file', 'generate file definitions'
      def file
        PuppetGenerator::Api::Create.new(options).file_definition
      end

      method_option :source,               Ui::CommandlineParserHelper.subcommand_options[:source]
      method_option :import_filter,        Ui::CommandlineParserHelper.subcommand_options[:import_filter]
      method_option :destination,          Ui::CommandlineParserHelper.subcommand_options[:destination]
      method_option :action,               Ui::CommandlineParserHelper.subcommand_options[:action]
      method_option :template_tagged_with, Ui::CommandlineParserHelper.subcommand_options[:template_tagged_with]
      method_option :export_filter,        Ui::CommandlineParserHelper.subcommand_options[:export_filter]
      desc 'user', 'generate user definitions'
      def user
        PuppetGenerator::Api::Create.new(options).user_definition
      end

      desc 'module', 'creates all files needed to build a module'
      def module
        PuppetGenerator::Api.new.generate_module(options)
      end

      method_option :source,               Ui::CommandlineParserHelper.subcommand_options[:source]
      method_option :import_filter,        Ui::CommandlineParserHelper.subcommand_options[:import_filter]
      method_option :destination,          Ui::CommandlineParserHelper.subcommand_options[:destination]
      method_option :action,               Ui::CommandlineParserHelper.subcommand_options[:action]
      method_option :template_tagged_with, Ui::CommandlineParserHelper.subcommand_options[:template_tagged_with]
      method_option :export_filter,        Ui::CommandlineParserHelper.subcommand_options[:export_filter]
      desc 'role', 'generate role definitions'
      def role
        PuppetGenerator::Api::Create.new(options).role_definition
      end

    end
  end
end
