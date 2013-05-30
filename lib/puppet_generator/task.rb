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

    attr_reader :meta
    attr_accessor :body, :logger

    define_type :error_message
    define_type :none

    def initialize(options={},type=:none)
      @type = type
      @meta = {}
      @body = nil
      @logger = nil

      @meta[:source]        = options[:source] 
      @meta[:destination]   = options[:destination]
      @meta[:module]        = options[:module]
      @meta[:class]         = options[:class]
      @meta[:requested_import_filter] = options[:import_filter]
      @meta[:requested_action]        = options[:action]
      @meta[:mode]                    = options[:debug] ? :debug : :normal

      set_task_type_to @type
    end

    private

    def set_task_type_to(type)
      self.public_send "is_#{type}_task".to_sym
    rescue
      raise Exceptions::InternalError
    end

  end
end
