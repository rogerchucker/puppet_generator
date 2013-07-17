module PuppetGenerator
  module EntryConverters
    class File
      def convert(entries)
        entries.collect { |e| OutputObjects::File.new( e ) }
      end
    end
  end
end
