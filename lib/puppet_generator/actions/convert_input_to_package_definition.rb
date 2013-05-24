module PuppetGenerator
  class ConvertInputToPackageDefinition
    def initialize(app)
      @app = app
    end

    def call(task)
      converter = PuppetGenerator::PackageDefinitionsConverter.new( task.body[:input].entries )
      task.body[:definitions] = converter.run

      @app.call(task)
    end
  end
end
