require 'spec_helper'


describe Models::Base do

  before(:each) {
    Models::Base.clear
  }

  it "is possible to register a message" do
    m1 = Models::Base.new('name')
    Models::Base.register m1
  end

  it "is possible to find an object" do
    m1 = Models::Base.new('name')
    Models::Base.register m1

    m_found = Models::Base.find('name')

    expect(m1).to eq(m_found)
  end

  it "is possible to create and register in one step" do
    m1 = Models::Base.create('name')
    m_found = Models::Base.find('name')

    expect(m1).to eq(m_found)
  end

  it "is possible to delete an object" do
    m1 = Models::Base.create('name')
    m2 = Models::Base.delete('name')

    expect(m1).to eq(m2)
  end

  it "is possible to delete all objects" do
    Models::Base.create('name1')
    Models::Base.create('name2')
    Models::Base.create('name3')

    Models::Base.clear
    expect(Models::Base.all).to eq( [] )
  end

end
