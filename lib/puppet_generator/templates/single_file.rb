module PuppetGenerator
  module Templates
    class SingleFile

      attr_reader :files

      def initialize(files)
        @files = files
        @template = Erubis::Eruby.new( 
        <<-EOF
class <%= @file.module_name %>::<%= @file.name %> {
  package {'<%= @file.name %>':
    ensure => latest,
  }
}
        EOF
        )
      end

      def render
        files.collect { |f| 
          Definition.new(p.name, @template.evaluate( file: f ) ) 
        }
      end
    end
  end
end
