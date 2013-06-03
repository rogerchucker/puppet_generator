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

        PuppetGenerator.logger.info(self.class.name){ "Puppet definitions will be output to \"#{task.meta[:destination]}\"."  }
        PuppetGenerator.logger.debug(self.class.name){ "Render template for channel \"#{channel}\" and sink \"#{sink}\"." }

        output = case channel
                 when 'file'
                   definitions = Models::Template.find(activated: true, handles_one_element_only: false).render(task.body)
                   PuppetGenerator::OutputFile.new( sink , definitions )
                 when /directory|dir/
                   definitions = Models::Template.find(activated: true, handles_one_element_only: true).render(task.body)
                   PuppetGenerator::OutputDirectory.new( sink , definitions )
                 when 'stdout'
                   definitions = Models::Template.find(activated: true, handles_one_element_only: true).render(task.body)
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
