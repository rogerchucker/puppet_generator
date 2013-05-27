module PuppetGenerator
  class Task
    class << self
      def define_type(type)
        define_method "is_#{type}_task".to_sym do
          @type = type.to_sym
        end

        define_method "is_#{type}_task?".to_sym do
          @type == type.to_sym
        end
      end
    end

    attr_reader :meta, :body

    def initialize
      @type = :none
      @meta = {}
      @body = {}
    end

    define_type :file
    define_type :package


  end
end
