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
    ensure => present,
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
