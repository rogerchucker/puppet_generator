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

        unless task.meta[:template_tagged_with]
          task.meta[:template_tagged_with] = case channel
                                             when /file/
                                               [ :many_per_file ]
                                             when /^(?:dir|directory)/
                                               [ :one_per_file ]
                                             when /stdout/
                                               [ :many_per_file ]
                                             else
                                               [ :many_per_file ]
                                             end
        end

        template = Models::Template.find(name: task.meta[:command], is_suitable_for: channel.to_sym, is_tagged_with: task.meta[:template_tagged_with] )
        raise Exceptions::InvalidTemplate unless template

        definitions = template.render(task.body)

        exporter = Models::Exporter.find(writes_to: task.meta[:destination])
        raise Exceptions::InvalidExporter unless exporter

        exporter.write(sink, definitions)

        @app.call(task)
      end

    end
  end
end
