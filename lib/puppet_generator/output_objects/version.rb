module PuppetGenerator
  module OutputObjects
    class Version

      attr_reader :version

      def initialize(entry)
        @version = entry[:name]
      end

      def name; end

      def suggested_file_name; end
    end
  end
end
