module PuppetGenerator
  module EntryConverters
    class Role
      def convert(entries, module_name, class_name)
        entries.collect { |e| PuppetObjects::Role.new( e, module_name , class_name ) }
      end
    end
  end
end
