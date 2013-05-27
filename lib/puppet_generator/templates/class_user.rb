module PuppetGenerator
  module Templates
    class ClassUser

      attr_reader :users

      def initialize(users)
        @users = users
        @template = Erubis::Eruby.new(
        <<-EOF
class <%= @users.first.module_name %>::<%= @users.first.class_name %> {
<% @users.each do |u| %>
  user {'<%= u.name %>':
    ensure => present,
  }
<% end %>
}
        EOF
        )
      end

      def render
        [ Definition.new( users.first.class_name, @template.evaluate(users: users) ) ]
      end

    end
  end
end
