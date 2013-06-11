module PuppetGenerator
  module EntryConverters
    class User
      def convert(entries, module_name, class_name)
        entries.collect { |e| PuppetUser.new( e, module_name , class_name ) }
      end
    end
  end
end
