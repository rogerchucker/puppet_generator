module PuppetGenerator
  module Templates
    class SingleUser

      attr_reader :users, :puppet_class

      def initialize(users)
        @users = users
        @template = Erubis::Eruby.new( 
        <<-EOF
class <%= @user.module_name %>::<%= @user.name %> {
  user {'<%= @user.name %>':
    ensure     => present,
    <% if @user.userid %>
    uid        => <%= @user.userid %>,
    <% end %>
    <% if @user.groupid %>
    gid        => <%= @user.groupid %>,
    <% end %>
    <% if @user.homedir %>
    homedir    => <%= @user.homedir %>,
    <% end %>
    <% if @user.shell %>
    shell      => <%= @user.shell %>,
    <% end %>
  }
}
        EOF
        )
      end

      def render
        users.collect { |u| 
          Definition.new(u.name, @template.evaluate( user: u ) ) 
        }
      end
    end
  end
end
