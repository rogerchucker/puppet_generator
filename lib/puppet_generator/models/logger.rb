module PuppetGenerator
  module Models
    def self.logger
      @logger ||= PuppetGenerator::Logger.new
    end

    def self.logger=(logger)
      @logger = logger
    end
  end
end
