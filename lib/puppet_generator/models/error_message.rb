module PuppetGenerator
  module Models
    class ErrorMessage < Base

      attr_accessor :preambel, :postscript
      class << self
        attr_accessor :preambel, :postscript
      end

      def initialize(name, template)
        super(name)
        @template = template
      end

      def text(options={})
        result = []
        result << ( preambel ? preambel : self.class.preambel )
        result << Erubis::Eruby.new(@template).evaluate(options)
        result << ( postscript ? postscript : self.class.postscript )

        result.join
      end
    end
  end
end
