require 'spec_helper'

require 'puppet_generator/entry_converters/version'

describe EntryConverters::Version do
  context '#convert' do
    it "prepares entries for output" do
      task = double( 'task' )
      task.stub(:meta)
      task.stub(:body).and_return( [ { 
        name: '1.1.1' ,
      } ] )

      result = EntryConverters::Version.new.convert(task.body).first.respond_to? :version
      expect(result).to eq(true)
    end

  end

end
