module PuppetGenerator
  module Middleware
    class CreateOutput
      def initialize(app)
        @app = app
      end

      def call(task)
        @task = task

        PuppetGenerator.logger.info(self.class.name){ "Puppet definitions will be output to \"#{task.meta[:destination]}\"."  }
        PuppetGenerator.logger.debug(self.class.name){ "Render template for channel \"#{channel}\" and sink \"#{sink}\"." }

        task.meta[:template_tagged_with] = determine_tags unless task.meta[:template_tagged_with]

        template = find_suitable_template( task.meta[:command], channel.to_sym, task.meta[:template_tagged_with] )
        exporter = find_suitable_exporter( task.meta[:destination] )

        definitions = template.render(task.body)
        exporter.write(sink, definitions)

        @app.call(task)
      end

      private

      def find_suitable_template(name,channel,tags)
        template = Models::Template.find(name: name, is_suitable_for: channel.to_sym, is_tagged_with: tags )
        raise Exceptions::WrongTemplateChosen unless template
        PuppetGenerator.logger.debug(self.class.name){ "Chosen template: #{template.name} (#{template.path})." }

        template
      end

      def find_suitable_exporter(destination)
        exporter = Models::Exporter.find( writes_to: destination )
        raise Exceptions::InvalidExporter unless exporter
        PuppetGenerator.logger.debug(self.class.name){ "Chosen exporter: #{exporter.name}." }

        exporter
      end

      def destination
        @task.meta[:destination].split(/:/)
      end
      
      def channel
        destination[0]
      end

      def sink
        destination[1]
      end

      def determine_tags
        case channel
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

    end
  end
end
