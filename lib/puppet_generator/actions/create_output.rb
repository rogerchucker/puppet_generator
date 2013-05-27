module PuppetGenerator
  class CreateOutput
    def initialize(app)
      @app = app
    end

    def call(task)
      output = case task.meta[:output_channel] 
      when 'file'
        definitions = Templates::ClassPackage.new( task.body[:packages] ).render
        PuppetGenerator::OutputFile.new( task.meta[:destination], definitions )
      when 'directory'
        definitions = Templates::SinglePackage.new( task.body[:packages] ).render
        PuppetGenerator::OutputDirectory.new( task.meta[:destination], definitions )
      when 'stdout'
        PuppetGenerator::OutputStdOut.new( task.body[:packages] )
      else
        raise PuppetGenerator::Exceptions::InvalidOutputChannel
      end
      output.write

      @app.call(task)
    end
  end
end
