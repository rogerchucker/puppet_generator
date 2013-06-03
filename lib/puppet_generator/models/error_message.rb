module PuppetGenerator
  module Models
    class ErrorMessage < Base

      attr_accessor :preambel, :postscript, :code
      class << self
        attr_accessor :preambel, :postscript

        def reset
          self.clear

          self.preambel = nil
          self.postscript = nil
        end
      end

      def initialize(name, code, template)
        super(name)

        @code = code
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
