module PuppetGenerator
  class CreateOutput
    def initialize(app)
      @app = app
    end

    def call(task)
    output_file = PuppetGenerator::OutputDirectory.new( task.meta[:destination], task.body[:packages] )
    output_file.write

    @app.call(task)
    end
  end
end
