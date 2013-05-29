require 'spec_helper'

describe ErrorMessage do

  it "supports equality" do
    m1 = ErrorMessage.new(1, 'Text')
    m2 = ErrorMessage.new(1, 'text233')

    expect(m1).to eq(m2)
  end

  it "supports not equality" do
    m1 = ErrorMessage.new(1, 'Text')
    m2 = ErrorMessage.new(2, 'text233')

    expect(m1).not_to eq(m2)
  end

  it "is possible to register a message" do
    m1 = ErrorMessage.new(1, 'Text')
    ErrorMessage.register m1
  end

  it "is possible to find a message" do
    m1 = ErrorMessage.new(1, 'Text')
    ErrorMessage.register m1

    m_found = ErrorMessage.find(1)

    expect(m1).to eq(m_found)
  end

  it "is possible to create and register in one step" do
    m1 = ErrorMessage.create(1, 'Text')
    m_found = ErrorMessage.find(1)

    expect(m1).to eq(m_found)
  end

end
