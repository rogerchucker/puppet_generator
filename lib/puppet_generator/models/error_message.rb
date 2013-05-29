module PuppetGenerator
  module Models
    class ErrorMessage < Base

      include Comparable

      attr_reader :code
      attr_accessor :preambel, :postscript

      class << self
        attr_accessor :preambel, :postscript

        def find(val)
          instances.find { |i| i.code == val }
        end
      end


      def initialize(code, text)
        @code = code
        @text = text
      end

      def <=>(other)
        code <=> other.code
      end

      def text
        result = []
        result << ( preambel ? preambel : self.class.preambel )
        result << @text
        result << ( postscript ? postscript : self.class.postscript )

        result.join
      end
    end
  end
end
