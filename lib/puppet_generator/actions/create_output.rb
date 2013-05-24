module PuppetGenerator
  class CreateOutput
    def initialize(app)
      @app = app
    end

    def call(task)

      output = case task.meta[:output_channel] 
      when 'file'
        template = TemplatePuppetClass.new( task.body[:class], task.body[:packages] )
        PuppetGenerator::OutputFile.new( task.meta[:destination], template )
      when 'directory'
        PuppetGenerator::OutputDirectory.new( task.meta[:destination], task.body[:packages] )
      when 'stdout'
        #PuppetGenerator::OutputStdOut.new( task.body[:packages], @template_class, @template_package )
        PuppetGenerator::OutputStdOut.new( task.body[:packages] )
      else
        raise PuppetGenerator::Exceptions::InvalidOutputChannel
      end
      output.write

      @app.call(task)
    end
  end
end
