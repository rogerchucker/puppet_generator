module PuppetGenerator
  class ReadInputUsers

    include ReadInputHelper

    def initialize(app)
      @app = app
    end

    def call(task)
      if is_stdin? task.meta[:source]
        task.body[:input] = PuppetGenerator::InputStdIn.new( task.body[:entry_creator] )
      elsif is_file? task.meta[:source]
        task.body[:input] = PuppetGenerator::InputFile.new( task.meta[:source] , task.body[:entry_creator] )
      else
        raise PuppetGenerator::Exceptions::InvalidSource
      end

      @app.call(task)
    end
  end
end
