module PuppetGenerator
  class Task

    attr_reader :meta, :body

    def initialize
      @meta = {}
      @body = {}
    end

  end
end
