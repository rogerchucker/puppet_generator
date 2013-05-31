module PuppetGenerator
  class Logger
    def initialize
      @logger = ::Logger.new($stderr)
    end
  end
end
