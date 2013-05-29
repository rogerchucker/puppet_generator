module PuppetGenerator
  module Models
    class ErrorMessage < Base

      include Comparable

      attr_reader :code
      attr_accessor :preambel, :postscript

      @preambel = nil

      class << self

        attr_accessor :preambel, :postscript

        def find(code)
          instances.find { |m| m.code == code }
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
