module PuppetGenerator
  module Models
    class ImportFilter < Base

      extend Forwardable
      def_delegator :@filter, :convert, :convert

      attr_reader :filter

      def initialize( name , filter )
        super(name)

        @filter = filter
      end

      def self.all_names_as_string(connector=", ")
        all.map(&:name).join(connector)
      end

    end
  end
end
