module PuppetGenerator
  module Models
    class Base

      include Comparable

      @instances = ::Set.new

      attr_reader :name

      def self.inherited(base)
        base.instance_variable_set(:@instances, Set.new)
      end

      class << self
        #attr_accessor :instances

        def register(element)
          @instances << element

          element
        end

        def create( *args, &block )
          if block_given?
            register( new( *args, &block ) )
          else
            register( new( *args ) )
          end
        end

        def find( val )
          @instances.find { |i| i.name == val.to_s.to_sym }
        end

        def delete( val )
          element = find( val.to_s.to_sym )
          raise Exceptions::InstanceNotFound unless element
          @instances.delete element

          element
        end

        def clear
          @instances = Set.new
        end

        def all
          @instances.to_a
        end
      end

      def initialize(name)
        @name = name.to_s.to_sym
      end

      def <=>(other)
        name <=> other.name
      end

      def eql?(other)
        name == other.name
      end

    end
  end
end
