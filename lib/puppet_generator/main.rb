module PuppetGenerator
  class << self
    def logger
      @logger ||= Logger.new
    end

    def library_name
      self
    end

    def gem_load_path
      library_name.downcase.underscore
    end

    def root_directory
      File.expand_path('../../../', __FILE__)
    end

    def enable_coverage_report
      require 'simplecov' 

      SimpleCov.start
      SimpleCov.command_name 'cucumber'
      SimpleCov.root PuppetGenerator.root_directory
    rescue
      self.logger.warn(self) { "Please note, this code is just for coverage testing. You need to install the \"simplecov\"-gem to make it work" }
    end
  end
end
