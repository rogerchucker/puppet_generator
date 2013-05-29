module PuppetGenerator
  class ErrorMessage

    include Comparable

    attr_reader :code
    attr_accessor :preambel

    @known_messages = Set.new
    @preambel = nil

    class << self

      attr_accessor :preambel

      def register(msg)
        @known_messages << msg
      end

      def create( code, text )
        message = ErrorMessage.new( code, text)
        ErrorMessage.register message

        message
      end

      def find(code)
        @known_messages.find { |m| m.code == code }
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

      result.join
    end
  end
end
