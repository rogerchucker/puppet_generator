module PuppetGenerator
  module EntryConverters
    class Package
      def convert(entries)
        entries.dup.collect { |e| OutputObjects::Package.new( e ) }
      end
    end
  end
end
