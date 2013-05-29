module PuppetGenerator
  module Models
    class Filter < Base

      attr_reader :filter

      def initialize( name , filter )
        super(name)

        @filter = filter
      end

    end
  end
end
