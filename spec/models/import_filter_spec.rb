
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
    Models::ImportFilter.init
    filter = Models::ImportFilter.find(:yaml)
    expect(filter.name).to eq(:yaml)
  end

  it "raises an error if an import filter is invalid: name error" do
    test_class = Class.new( Models::ImportFilter ) do
      def self.filter
        File.join( examples_dir, 'import_filter', 'invalid_filter_1.rb' )
      end

      def self.require_path(name)
        File.join( examples_dir, 'import_filter', 'invalid_filter_1' )
      end
    end

    expect {
      test_class.init
    }.to raise_error Exceptions::InvalidImportFilter
  end

  it "raises an error if an import filter is invalid: missing method" do
    test_class = Class.new( Models::ImportFilter ) do
      def self.filter
        File.join( examples_dir, 'import_filter', 'invalid_filter_2.rb' )
      end

      def self.require_path(name)
        File.join( examples_dir, 'import_filter', 'invalid_filter_2' )
      end
    end

    expect {
      test_class.init
    }.to raise_error Exceptions::InvalidImportFilter
  end

end
