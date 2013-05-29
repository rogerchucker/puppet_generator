
require 'spec_helper'

describe Models::Filter do
  it "supports equality" do
    m1 = Models::Filter.new(:name, 'Text')
    m2 = Models::Filter.new(:name, 'Text123')

    expect(m1).to eq(m2)
  end

  it "supports not equality" do
    m1 = Models::Filter.new(:name1, 'Text')
    m2 = Models::Filter.new(:name2, 'Text123')

    expect(m1).not_to eq(m2)
  end

end
