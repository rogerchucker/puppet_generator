module PuppetGenerator
  module EntryConverters
    class Version
      def convert(entries)
        entries.dup.collect { |e| OutputObjects::Version.new( e ) }
      end
    end
  end
end
