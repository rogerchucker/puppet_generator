module PuppetGenerator
  module EntryConverters
    class User
      def convert(entries)
        entries.dup.collect { |e| OutputObjects::User.new( e ) }
      end
    end
  end
end
