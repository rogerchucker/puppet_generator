module PuppetGenerator
  class GeneratePackageDefinition
    def initialize(app)
      @app = app
    end

    def call(task)
      converter = PuppetGenerator::PackageDefinitionsGenerator.new( task.body[:packages] )
      task.body[:definitions] = converter.run

      @app.call(task)
    end
  end
end
