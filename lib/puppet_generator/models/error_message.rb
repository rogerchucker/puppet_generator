module PuppetGenerator
  class ErrorMessage

    include Comparable

    attr_reader :code
    attr_accessor :preambel, :postscript

    @instances = Set.new
    @preambel = nil

    class << self

      attr_accessor :preambel, :postscript

      def register(instance)
        @instances << instance

        instance
      end

      def create( code, text )
        register new( code, text)
      end

      def find(code)
        @instances.find { |m| m.code == code }
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
