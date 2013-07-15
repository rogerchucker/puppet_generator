module PuppetGenerator
  module Middleware
    class CreateOutput
      def initialize(app)
        @app = app
      end

      def call(task)
        @task = task

        PuppetGenerator.logger.info(self.class.name){ "Puppet definitions will be output to \"#{task.meta[:destination]}\"."  }
        PuppetGenerator.logger.debug(self.class.name){ "Render view for channel \"#{channel}\" and sink \"#{sink}\"." }

        task.meta[:type_of_view] = default_type_of_view_for(channel) unless task.meta[:type_of_view]

        view = find_suitable_view( task.meta[:command_chain].last, task.meta[:command_chain].first, channel.to_sym, task.meta[:type_of_view] )
        exporter = find_suitable_exporter( task.meta[:destination] )

        definitions = view.render(task.body)
        exporter.write(sink, definitions)

        @app.call(task)
      end

      private

      def find_suitable_view(resource,verb,channel,type_of_view)
        view = Models::View.find(resource: resource, verb: verb, supports_enum_as_input:  wants_enum_as_input?( type_of_view ) )
        raise Exceptions::WrongViewChosen unless view
        PuppetGenerator.logger.debug(self.class.name){ "Chosen view: #{view.name} (#{view.path})." }

        view
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

      def wants_enum_as_input?( type_of_view )
        case type_of_view
        when :many
          true
        when :one
          false
        else
          true
        end
      end

      def default_type_of_view_for(output)
        case output
        when /file/
          :many
        when /^(?:dir|directory)/
          :one
        when /stdout/
          :many
        else
          :many
        end
      end

    end
  end
end
