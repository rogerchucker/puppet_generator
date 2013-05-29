module PuppetGenerator
  module Models
    class Base

      def self.inherited(base)
        base.instance_variable_set(:@instances, Set.new)
      end

      class << self
        attr_reader :instances

        def register(i)
          instances << i

          i
        end

        def create( *args )
          register new( *args )
        end

      end
    end
  end
end
