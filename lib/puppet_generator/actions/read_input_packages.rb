module PuppetGenerator
  class ReadInputPackages

    include ReadInputHelper

    def initialize(app)
      @app = app
    end

    def call(task)
      task.logger.debug("read input for packages")
      if is_stdin? task.meta[:source]
        task.body = PuppetGenerator::InputStdIn.new.lines
      elsif is_file? task.meta[:source]
        task.body = PuppetGenerator::InputFile.new( task.meta[:source] ).lines
      else
        raise PuppetGenerator::Exceptions::InvalidSource
      end

      @app.call(task)
    end
  end
end
