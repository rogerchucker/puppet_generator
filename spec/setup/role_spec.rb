require 'spec_helper'

describe Setup::Role do
  before(:each) do
    Models::ImportFilter.clear
    Models::Template.clear
    Models::Action.clear
    Models::Importer.clear
    Models::ExportFilter.clear
  end

  it "enables default values" do

    s = Setup::Role.new( HashWithIndifferentAccess.new )
    s.setup_environment

    expect(Models::ImportFilter.find_all(enabled: true).size).to eq(2)
    expect(Models::Template.find_all(enabled: true).size).to eq(2)
    expect(Models::Action.find_all(enabled: true).size).to eq(1)
    expect(Models::Importer.find_all(enabled: true).size).to eq(3)
    expect(Models::ExportFilter.find_all(enabled: true).size).to eq(2)

  end
end
