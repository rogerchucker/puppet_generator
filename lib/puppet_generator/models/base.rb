module PuppetGenerator
  module Models
    class Base

      include Comparable

      @instances = Set.new

      attr_reader :name

      def self.inherited(base)
        base.instance_variable_set(:@instances, Set.new)
      end

      class << self
        #attr_accessor :instances

        def register(i)
          @instances << i

          i
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
          if val == :all
            @instances = Set.new
          else
            i = find( val.to_s.to_sym )
            raise Exceptions::InstanceNotFound unless i
            @instances.delete i

            i
          end
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
