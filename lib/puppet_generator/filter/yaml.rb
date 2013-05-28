module PuppetGenerator
  module Filter
    class Yaml
      def convert(lines)
        hash_keys_from_str_to_sym(Psych.load(lines.join("\n")))
      end

      private

      def hash_keys_from_str_to_sym(hash)
        hash.inject([]) do |result,(name,attributes)|
          result << attributes.inject( { name: name} ) { |result, (k,v)| result[k.to_sym] = v; result }
        end
      rescue
        raise Exceptions::InvalidYamlInput
      end

    end
  end
end
