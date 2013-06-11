module PuppetGenerator
  module EntryConverters
    class File
      def convert(entries, module_name, class_name)
        entries.collect { |e| PuppetFile.new( e, module_name , class_name ) }
      end
    end
  end
end
