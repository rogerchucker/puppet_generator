module PuppetGenerator
  module Templates
    class SingleFile

      attr_reader :files

      def initialize(files)
        @files = files
        @template = Erubis::Eruby.new( 
        <<-EOF
class <%= @file.module_name %>::<%= @file.name %> {
  file {'<%= @file.path %>':
    ensure => file,
    <% if @file.source %>
    source => <%= @file.source %>,
    <% end %>
    <% if @file.owner %>
    owner  => <%= @file.owner %>,
    <% end %>
    <% if @file.mode %>
    mode   => <%= @file.mode %>,
    <% end %>
  }
}
        EOF
        )
      end

      def render
        files.collect { |f| 
          Definition.new(f.name, @template.evaluate( file: f ) ) 
        }
      end
    end
  end
end
