module PuppetGenerator
  module Models
    class ErrorMessage < Base

      attr_accessor :preambel, :postscript
      class << self
        attr_accessor :preambel, :postscript
      end

      def initialize(name, text)
        super(name)
        @text = text
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
