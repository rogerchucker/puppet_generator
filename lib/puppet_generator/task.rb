module PuppetGenerator
  class Task
    class << self
      def define_type(type)
        define_method "is_#{type}_task".to_sym do
          instance_variable_set(:@type, type.to_sym)
        end

        define_method "is_#{type}_task?".to_sym do
          instance_variable_get(:@type) == type.to_sym
        end
      end
    end

    attr_reader :meta, :logger
    attr_accessor :body

    def initialize(options={},type=nil)
      @type = :none
      @meta = {}
      @body = nil
      @logger = Logger.new($stderr)

      if options[:debug]
        @logger.level = Logger::DEBUG
      else
        @logger.level = Logger::WARN
      end

      @meta[:source]        = options[:source] 
      @meta[:destination]   = options[:destination]
      @meta[:module]        = options[:module]
      @meta[:class]         = options[:class]

      case type.to_sym
      when :package
        @type = :package
      when :file
        @type = :file
      when :user
        @type = :user
      else
        raise Exceptions::InternalError
      end
    end

    define_type :file
    define_type :package
    define_type :user

  end
end
