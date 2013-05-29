module PuppetGenerator
  class ErrorMessage

    include Comparable

    attr_reader :code, :text

    @known_messages = Set.new

    class << self

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
  end
end
