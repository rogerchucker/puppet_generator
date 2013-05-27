module PuppetGenerator
  module Templates
    class ClassFile

      attr_reader :files

      def initialize(files)
        @files = files
        @template = Erubis::Eruby.new(
        <<-EOF
class <%= @files.first.module_name %>::<%= @files.first.class_name %> {
<% @files.each do |f| %>
  file {'<%= f.name %>':
    ensure => file,
    <% if f.source %>
    source => <%= f.source %>,
    <% end %>
    <% if f.owner %>
    owner  => <%= f.owner %>,
    <% end %>
    <% if f.mode %>
    mode   => <%= f.mode %>,
    <% end %>
  }
<% end %>
}
        EOF
        )
      end

      def render
        [ Definition.new( files.first.class_name, @template.evaluate(files: files) ) ]
      end

    end
  end
end
