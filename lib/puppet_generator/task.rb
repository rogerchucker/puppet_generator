module PuppetGenerator
  class Task

    include PuppetHelper

    attr_reader :meta
    attr_accessor :body

    def initialize(options={})
      @meta = {}
      @body = nil

      @meta[:source]        = options[:source] 
      @meta[:destination]   = options[:destination]
      @meta[:module]        = puppet_module_name( options[:module] )
      @meta[:class]         = puppet_class_name( options[:class] )
      @meta[:requested_import_filter] = options[:import_filter]
      @meta[:requested_export_filter] = options[:export_filter]
      @meta[:requested_actions]        = options[:action]
      @meta[:logging_mode]             = log_level(options)
      @meta[:command]       = options[:command] 
      @meta[:template_tagged_with]       = options[:template_tagged_with].split(/:/).map(&:to_sym) if options[:template_tagged_with]
      @meta[:debug]         = true if options[:debug]
    end

    private

    def log_level(options)
      if options[:silent]
        return :silent
      elsif options[:debug]
        return :debug
      else
        return :info
      end
    end

  end
end
