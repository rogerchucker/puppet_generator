module PuppetGenerator
  module EntryConverters
    class File
      def convert(entries)
        entries.dup.collect { |e| OutputObjects::File.new( e ) }
      end
    end
  end
end
