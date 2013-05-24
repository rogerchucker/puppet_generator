module PuppetGenerator
  class ConvertInputToPackageDefinition
    def initialize(app)
      @app = app
    end

    def call(task)
      task.body[:definitions] = PuppetGenerator::PackageDefinitionsConverter.new( task.body[:input].entries )

      @app.call(task)
    end
  end
end
