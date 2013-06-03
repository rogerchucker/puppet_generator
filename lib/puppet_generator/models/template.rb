module PuppetGenerator
  module Models
    class Template < Base

      #create new instance of template model
      def initialize( name , template_path, handles_one_element_only=true )
        super(name)

        @template_path = template_path
        @handles_one_element_only = handles_one_element_only
        @enabled = false
      end

      #enable filter
      def enable
        @enabled = true
      end

      #check if filter is enabled
      def enabled?(val=true)
        @enabled == val
      end

      #check if template is for one or many
      #elements
      def handles_one_element_only?(val=true)
        @handles_one_element_only == val
      end

      # render the template based on files
      def render(items)

        if handles_one_element_only?
          return items.collect { |item| Definition.new( item.name, template.evaluate( item: item ) ) }
        else
          return [ Definition.new( items.first.class_name , template.evaluate( items: items ) ) ]
        end

      rescue
        raise Exceptions::InvalidTemplate, "An invalid template \"#{@template_path}\" was used. Please check and correct the syntax and try again."
      end

      private

      def template
        Erubis::Eruby.new( template_content )
      rescue
        raise Exceptions::InvalidTemplate, "An invalid template \"#{@template_path}\" was used. Please check and correct the syntax and try again."
      end

      def template_content
        File.read( @template_path )
      end

      public

      class << self
        #initialize model
        def init
          load_from_filesystem
        end

        #return all names as string
        def all_names_as_string(connector=", ")
          find_all(enabled: true).map(&:name).sort.join(connector)
        end

        #enables a specific instance
        def enable(name)
          find(name: name).enable
        end

        #finds a single instance
        def find( criteria={} )
          find_all( criteria ).first
        end

        #finds all instances
        def find_all( criteria={} )
          criteria = { name: criteria.to_sym } if criteria.kind_of? Symbol or criteria.kind_of? String

          @instances.find_all do |i| 
            criteria.all? do |c,v|
              i.send( "#{c}?".to_sym , v )
            end
          end

        rescue
          raise Exceptions::InvalidSearchCriteria
        end

        private

        def filter
          path = File.expand_path('../../../../templates/puppet', __FILE__ )

          File.join(path,'**', '*.pp.erb')
        end

        def load_from_filesystem
          files = Dir.glob( filter )

          files.each do |f| 
            create( name( f ) , f, template_is_for_one_element_only?( f ) )
          end

        end

        def template_is_for_one_element_only?(path)
          if path =~ %r[/one/]
            return true
          else
            return false
          end
        end

        def name(path)
          name = File.basename(path, '.pp.erb').to_sym
          raise Exceptions::UnauthorizedUseOfKeyword if forbidden_keywords.include? name

          name
        end

        def forbidden_keywords
          [ ]
        end

      end
    end
  end
end
