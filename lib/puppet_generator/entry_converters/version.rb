module PuppetGenerator
  module EntryConverters
    class Version
      def convert(entries)
        entries.collect { |e| OutputObjects::Version.new( e ) }
      end
    end
  end
end
