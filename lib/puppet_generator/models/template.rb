module PuppetGenerator
  module Models
    class Template < Base

      attr_reader :template

      def initialize( name , template )
        super(name)

        @template = template
      end

      def self.all_names_as_string(connector=", ")
        all.map(&:name).join(connector)
      end

    end
  end
end
