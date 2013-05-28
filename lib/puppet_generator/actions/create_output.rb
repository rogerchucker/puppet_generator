module PuppetGenerator
  class CreateOutput
    def initialize(app)
      @app = app
    end

    def call(task)
      destination = task.meta[:destination].split(/:/)
      channel     = destination[0]
      sink        = destination[1]

      task.logger.debug(self.class.name){ "render template for channel \"#{channel}\" and sink \"#{sink}\"" }
      output = case channel
               when 'file'
                 definitions = task.meta[:templates][:class].new( task.body ).render
                 PuppetGenerator::OutputFile.new( sink , definitions )
               when /directory|dir/
                 definitions = task.meta[:templates][:single].new( task.body ).render
                 PuppetGenerator::OutputDirectory.new( sink , definitions )
               when 'stdout'
                 definitions = task.meta[:templates][:single].new( task.body ).render
                 PuppetGenerator::OutputStdOut.new( definitions )
               else
                 raise PuppetGenerator::Exceptions::InvalidOutputChannel
               end
      output.write

      @app.call(task)
    end

  end
end
