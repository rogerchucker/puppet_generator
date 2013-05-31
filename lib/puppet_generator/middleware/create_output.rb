module PuppetGenerator
  module Middleware
    class CreateOutput
      def initialize(app)
        @app = app
      end

      def call(task)
        destination = task.meta[:destination].split(/:/)
        channel     = destination[0]
        sink        = destination[1]

        task.logger.debug(self.class.name){ "Render template for channel \"#{channel}\" and sink \"#{sink}\"." }

        output = case channel
                 when 'file'
                   definitions = Models::Template.find(:class).template.new( task.body ).render
                   PuppetGenerator::OutputFile.new( sink , definitions )
                 when /directory|dir/
                   definitions = Models::Template.find(:single).template.new( task.body ).render
                   PuppetGenerator::OutputDirectory.new( sink , definitions )
                 when 'stdout'
                   definitions = Models::Template.find(:single).template.new( task.body ).render
                   PuppetGenerator::OutputStdOut.new( definitions )
                 else
                   raise PuppetGenerator::Exceptions::InvalidOutputChannel
                 end
        output.write

        @app.call(task)
      end

    end
  end
end
