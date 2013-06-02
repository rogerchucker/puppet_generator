
require 'spec_helper'

describe Models::ImportFilter do
  before(:each) do
    Models::ImportFilter.clear
  end

  it "returns a string of all active filters" do
    Models::ImportFilter.create(:name1, 'Text1')
    Models::ImportFilter.create(:name2, 'Text2')

    result = Models::ImportFilter.all_names_as_string(", ")
    expect(result).to eq("name1, name2")

    result = Models::ImportFilter.all_names_as_string
    expect(result).to eq("name1, name2")
  end

  it "finds all available filter" do
    Models::ImportFilter.send(:load_from_filesystem)
    expect(Models::ImportFilter.all).not_to eq([])
  end

end
