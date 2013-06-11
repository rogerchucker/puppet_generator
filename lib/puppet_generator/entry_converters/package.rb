module PuppetGenerator
  module EntryConverters
    class Package
      def convert(entries, module_name, class_name)
        entries.collect { |e| PuppetPackage.new( e, module_name , class_name ) }
      end
    end
  end
end
