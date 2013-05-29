require 'spec_helper'

describe Models::ErrorMessage do

  before(:each) {
    Models::ErrorMessage.preambel = nil
    Models::ErrorMessage.postscript = nil
  }

  it "supports equality" do
    m1 = Models::ErrorMessage.new(1, 'Text')
    m2 = Models::ErrorMessage.new(1, 'text233')

    expect(m1).to eq(m2)
  end

  it "supports not equality" do
    m1 = Models::ErrorMessage.new(1, 'Text')
    m2 = Models::ErrorMessage.new(2, 'text233')

    expect(m1).not_to eq(m2)
  end

  it "is possible to find a message" do
    m1 = Models::ErrorMessage.new(1, 'Text')
    Models::ErrorMessage.register m1

    m_found = Models::ErrorMessage.find(1)

    expect(m1).to eq(m_found)
  end

  it "is possible to define a preambel for all error messages" do
    Models::ErrorMessage.preambel = "test\n\n"
    m1 = Models::ErrorMessage.create(1, 'Text')
    expect(m1.text).to eq("test\n\nText")
  end

  it "is possible to define a preambel for a single error messages" do
    m1 = Models::ErrorMessage.create(1, 'Text')
    m1.preambel = "test123\n\n"

    expect(m1.text).to eq("test123\n\nText")
  end

  it "returns only the instance preambel if both are defined" do
    m1 = Models::ErrorMessage.create(1, 'Text')
    Models::ErrorMessage.preambel = "from class\n\n"
    m1.preambel = "from instance\n\n"

    expect(m1.text).to eq("from instance\n\nText")
  end

  it "is possible to define a postscript for all error messages" do
    Models::ErrorMessage.postscript = "\n\npostscript"
    m1 = Models::ErrorMessage.create(1, 'Text')
    expect(m1.text).to eq("Text\n\npostscript")
  end

  it "is possible to define a postscript for a single error messages" do
    m1 = Models::ErrorMessage.create(1, 'Text')
    m1.postscript = "\n\npostscript"
    expect(m1.text).to eq("Text\n\npostscript")
  end

  it "returns only the instance postscript if both are defined" do
    m1 = Models::ErrorMessage.create(1, 'Text')
    Models::ErrorMessage.postscript = "\n\npostscript from class"
    m1.postscript = "\n\npostscript from instance"

    expect(m1.text).to eq("Text\n\npostscript from instance")
  end

end
