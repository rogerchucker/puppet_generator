require 'spec_helper'


describe Models::Base do

  it "is possible to register a message" do
    m1 = Models::Base.new('name')
    Models::Base.register m1
  end

  it "is possible to create and register in one step" do
    m1 = Models::Base.create('name')
    m_found = Models::Base.find('name')

    expect(m1).to eq(m_found)
  end

end
