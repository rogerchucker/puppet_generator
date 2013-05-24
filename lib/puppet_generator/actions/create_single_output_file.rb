module PuppetGenerator
  class CreateSingleOutputFile
    def initialize(app)
      @app = app
    end

    def call(task)
    output_file = PuppetGenerator::OutputFile.new( task.meta[:output], converter.run)
    output_file.write

    @app.call(task)
    end
  end
end
