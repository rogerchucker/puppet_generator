require 'spec_helper'

describe Models::Action do
  before(:each) {
    Models::Action.clear
  }

  it "returns a string of all active actions" do
    Models::Action.create(:name1, 'Text1')
    Models::Action.create(:name2, 'Text2')

    result = Models::Action.all_names_as_string(", ")
    expect(result).to eq("name1, name2")

    result = Models::Action.all_names_as_string
    expect(result).to eq("name1, name2")
  end
end
