require 'spec_helper'

require 'puppet_generator/entry_converters/user'

describe EntryConverters::User do
  context '#convert' do
    it "prepares entries for output" do
      task = double( 'task' )
      task.stub(:meta)
      task.stub(:body).and_return( [ { 
        name: 'asdf' ,
        module: 'asfd',
        class: 'asdf',
      } ] )

      result = EntryConverters::User.new.convert(task.body).first.respond_to? :suggested_file_name
      expect(result).to eq(true)
    end

  end

end
