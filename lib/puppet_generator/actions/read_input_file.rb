module PuppetGenerator
  class ReadInputFile
    def initialize(app)
      @app = app
    end

    def call(task)
      task.body[:input] = PuppetGenerator::InputFile.new( task.meta[:input_file_name] )

      @app.call(task)
    end
  end
end
