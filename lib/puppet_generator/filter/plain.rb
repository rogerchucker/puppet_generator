module PuppetGenerator
  module Filter
    class Plain
      def convert(lines)
        lines.collect { |line| { name: line } }
      end
    end
  end
end
