
require 'spec_helper'

describe Models::Template do

  it "returns a string of all active filters" do
    Models::Template.create(:name1, 'Text1')
    Models::Template.create(:name2, 'Text2')

    result = Models::Template.all_names_as_string(", ")
    expect(result).to eq("name1, name2")

    result = Models::Template.all_names_as_string
    expect(result).to eq("name1, name2")
  end

end
