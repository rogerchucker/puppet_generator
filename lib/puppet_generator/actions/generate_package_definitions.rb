module PuppetGenerator
  class GeneratePackageDefinitions
    def initialize(app)
      @app = app
    end

    def call(task)
      task.body[:definitions] = PuppetGenerator::PackageDefinitionsGenerator.new( task.body[:packages] ).run

      @app.call(task)
    end
  end
end
