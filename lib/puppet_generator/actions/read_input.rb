module PuppetGenerator
  class ReadInput
    def initialize(app)
      @app = app
    end

    def call(task)
      if is_directory? task.meta[:source]
        task.body[:input] = PuppetGenerator::InputDirectory.new( task.meta[:source] )
      elsif is_file? task.meta[:source]
        task.body[:input] = PuppetGenerator::InputFile.new( task.meta[:source] )
      else
        raise PuppetGenerator::Exceptions::InvalidSource
      end

      binding.pry

      @app.call(task)
    end

    private

    def is_directory?(item)
      FileTest.directory? item
    end

    def is_file?(item)
      FileTest.file? item
    end

  end
end
