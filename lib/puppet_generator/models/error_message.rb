module PuppetGenerator
  module Models
    class ErrorMessage < Base

      attr_accessor :preambel, :postscript
      class << self
        attr_accessor :preambel, :postscript
      end

      def initialize(name, &block)
        super(name)
        @text = block.call
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
