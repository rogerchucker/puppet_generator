
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

  it "an import filter uses a forbidden keywords as name" do
    test_class = Class.new( Models::ImportFilter ) do
      def self.filter
        File.join( examples_dir, 'import_filter', 'forbidden_keyword.rb' )
      end

      def self.require_path(name)
        File.join( examples_dir, 'import_filter', 'forbidden_keyword' )
      end

      def self.forbidden_keywords
        [ :forbidden_keyword ]
      end
    end

    expect {
      test_class.init
    }.to raise_error Exceptions::UnauthorizedUseOfKeyword
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

  it "is default that all found filters are deactivated" do
    Models::ImportFilter.init
    all_filter = Models::ImportFilter.all
    all_not_activated_filter = Models::ImportFilter.all.find_all {|f| f.activated? == false }
    expect(all_filter.size).to eq(all_not_activated_filter.size)
  end

  it "activates a filter by request" do
    Models::ImportFilter.init
    Models::ImportFilter.activate(:yaml)
    all_activated_filter = Models::ImportFilter.all.find_all {|f| f.activated? == true }

    expect(all_filter.size).to eq(all_not_activated_filter.size)
  end

  it "finds only activated import filter" do
    #pending
  end

end
