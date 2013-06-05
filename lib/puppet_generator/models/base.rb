module PuppetGenerator
  module Models
    class Base

      include Comparable

      @instances = ::Set.new

      attr_reader :name

      def self.inherited(base)
        base.instance_variable_set(:@instances, Set.new)
      end

      def initialize(name)
        @name = name.to_sym
        @enabled = false
      end

      #enable action
      def enable
        @enabled = true
      end

      #check if action is enabled
      def enabled?(val=true)
        @enabled == val
      end

      def name?(name)
        @name == name
      end

      def <=>(other)
        name <=> other.name
      end

      def eql?(other)
        name == other.name
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

        #return all names as string
        def all_names_as_string(connector=", ")
          find_all(enabled: true).map(&:name).sort.join(connector)
        end

        #enables a specific instance
        def enable(name)
          find(name: name).enable
        end

        #finds a single instance
        def find( criteria={} )
          find_all( criteria ).first
        end

        #finds all instances
        def find_all( criteria={} )
          PuppetGenerator::Models.logger.debug(self) { "Criteria for search: #{ criteria }" }
          criteria = { name: criteria.to_sym } if criteria.kind_of? Symbol or criteria.kind_of? String

          PuppetGenerator::Models.logger.debug(self) { "Instances to be searched for: #{ @instances.map { |i| "#{i.name} (#{i.class})" }.join(", ") }" }
          @instances.find_all do |i| 
            criteria.all? do |c,v|

              PuppetGenerator::Models.logger.debug(self) { "Check method for search: #{ c }" }
              i.send( "#{c}?".to_sym , v )
            end
          end

        rescue NameError => e
          raise Exceptions::InvalidSearchCriteria, e.message
        end
      end

    end
  end
end
