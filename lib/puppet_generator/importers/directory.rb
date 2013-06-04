module PuppetGenerator
  module Importers
    class Directory
      attr_reader :lines

      def initialize( directory )
        @lines = []
        ::Find.find( directory) { |path| @lines << path }
      end

    end
  end
end
