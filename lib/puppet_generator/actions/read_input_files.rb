module PuppetGenerator
  class ReadInputFiles

    include ReadInputHelper

    def initialize(app)
      @app = app
    end

    def call(task)
      if is_directory? task.meta[:source]
        task.body[:input] = PuppetGenerator::InputDirectory.new( task.meta[:source] )
      elsif is_stdin? task.meta[:source]
        task.body[:input] = PuppetGenerator::InputStdIn.new
      elsif is_file? task.meta[:source]
        task.body[:input] = PuppetGenerator::InputFile.new( task.meta[:source] )
      else
        raise PuppetGenerator::Exceptions::InvalidSource
      end

      @app.call(task)
    end

  end
end
