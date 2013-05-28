module PuppetGenerator
  class ReadInputUsers

    include ReadInputHelper

    def initialize(app)
      @app = app
    end

    def call(task)
      task.logger.debug("read input for users")
      if is_stdin? task.meta[:source]
        task.body = PuppetGenerator::InputStdIn.new( task.meta[:entry_creator] )
      elsif is_file? task.meta[:source]
        task.body = PuppetGenerator::InputFile.new( task.meta[:source] , task.meta[:entry_creator] )
      else
        raise PuppetGenerator::Exceptions::InvalidSource
      end

      @app.call(task)
    end
  end
end
