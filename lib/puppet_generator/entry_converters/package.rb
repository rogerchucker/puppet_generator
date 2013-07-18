module PuppetGenerator
  module EntryConverters
    class Package
      def convert(entries)
        entries.collect { |e| OutputObjects::Package.new( e ) }
      end
    end
  end
end
