module PuppetGenerator
  class CreateOutput
    def initialize(app)
      @app = app
    end

    def call(task)
      destination = task.meta[:destination].split(/:/)
      channel     = destination[0]
      sink        = destination[1]

      output = case channel
               when 'file'
                 definitions = task.body[:templates][:class].new( task.body[:packages] ).render
                 PuppetGenerator::OutputFile.new( sink , definitions )
               when /directory|dir/
                 definitions = task.body[:templates][:single].new( task.body[:packages] ).render
                 PuppetGenerator::OutputDirectory.new( sink , definitions )
               when 'stdout'
                 definitions = task.body[:templates][:single].new( task.body[:packages] ).render
                 PuppetGenerator::OutputStdOut.new( definitions )
               else
                 raise PuppetGenerator::Exceptions::InvalidOutputChannel
               end
      output.write

      @app.call(task)
    end

  end
end
