module PuppetGenerator
  module Setups
    class CreateUser < Base

      def description
        "Create user"
      end

      def environment
        use_defaults_for :error_message, :import_filter, :action, :importer, :export_filter
        enable_all_of :action

        enable_import_filter :passwd
        enable_template_for :create_user
      end

    end
  end
end
