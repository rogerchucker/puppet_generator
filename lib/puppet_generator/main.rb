module PuppetGenerator
  class << self
    def logger
      @logger ||= Logger.new
    end

    def library_name
      self.to_s
    end

    def gem_load_path
      library_name.underscore
    end

    def root_directory
      File.expand_path('../../../', __FILE__)
    end

    def enable_coverage_report
      require 'simplecov' 

      SimpleCov.start
      SimpleCov.command_name( "cucumber_#{Random.srand}" )
      SimpleCov.root PuppetGenerator.root_directory
    rescue
      self.logger.warn(self) { "Please note, this code is just for coverage testing. You need to install the \"simplecov\"-gem to make it work" }
    end

    def enable_debugging_libraries
      require 'pry' 
      require 'debugger'
    rescue
      self.logger.warn(self) { "Please note, this code is just for debugging the library. You need to install the \"ruby-debug19\"- and \"pry\"-gem to make it work" }
    end
  end
end
