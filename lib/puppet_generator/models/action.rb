module PuppetGenerator
  module Models
    # model for import action
    class Action < Base

      include FilesystemBasedModel

      extend Forwardable

      #@!method convert
      #   converts an object using the convert method of 
      #   the stored action
      def_delegator :@action, :run, :run

      #create new instance of action model
      def initialize( name , action )
        super(name)

        @action = action
        @enabled = false
      end

      class << self
        def load_from_filesystem
          files = Dir.glob( path_to_instances )

          files.each do |f| 
            action_name = name( f )

            require require_path( action_name )

            action_class = build_class_constant( action_name )
            check_klass( action_class, :run )
            create( action_name , action_class.new )
          end
        end
      end
    end
  end
end
