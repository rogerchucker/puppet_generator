module PuppetGenerator
  module Filter
    class Null
      def convert(lines)
        lines.collect { |line| { name: line.strip } }
      end
    end
  end
end
