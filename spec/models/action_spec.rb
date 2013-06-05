require 'spec_helper'

describe Models::Action do
  before(:each) {
    Models::Action.clear
  }

  it "finds all available actions" do
    Models::Action.init
    action = Models::Action.find(:null)
    expect(action.name).to eq(:null)
  end
end
