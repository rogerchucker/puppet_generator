require 'spec_helper'

require 'puppet_generator/actions/null'

describe Actions::Null do
  context '#run' do

    it "does not modify and run anything" do
      task = double( 'task' )
      task.stub(:meta)
      task.stub(:body).and_return( { name: 'asdf' } )

      action = Actions::Null.new
      result = action.run(task.body,task.meta)
      expected_result = { name: 'asdf' }

      expect(result).to eq(expected_result)
    end

  end

end
