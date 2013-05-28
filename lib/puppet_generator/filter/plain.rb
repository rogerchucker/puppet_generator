module PuppetGenerator
  module Filter
    class Plain
      def convert(lines)
        lines.collect { |line| Hash.new(name: line) }
      end
    end
  end
end
