
require 'spec_helper'

describe Models::ImportFilter do
  it "supports equality" do
    m1 = Models::ImportFilter.new(:name, 'Text')
    m2 = Models::ImportFilter.new(:name, 'Text123')

    expect(m1).to eq(m2)
  end

  it "supports not equality" do
    m1 = Models::ImportFilter.new(:name1, 'Text')
    m2 = Models::ImportFilter.new(:name2, 'Text123')

    expect(m1).not_to eq(m2)
  end

  it "returns a string of all active filters" do
    Models::ImportFilter.create(:name1, 'Text1')
    Models::ImportFilter.create(:name2, 'Text2')

    result = Models::ImportFilter.all_names_as_string(", ")
    expect(result).to eq("name1, name2")

    result = Models::ImportFilter.all_names_as_string
    expect(result).to eq("name1, name2")
  end

end
