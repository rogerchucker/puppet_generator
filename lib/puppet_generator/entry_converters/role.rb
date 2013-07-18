module PuppetGenerator
  module EntryConverters
    class Role
      def convert(entries)
        entries.dup.collect { |e| OutputObjects::Role.new( e ) }
      end
    end
  end
end
