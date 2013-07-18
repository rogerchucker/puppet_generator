module PuppetGenerator
  module EntryConverters
    class User
      def convert(entries)
        entries.collect { |e| OutputObjects::User.new( e ) }
      end
    end
  end
end
