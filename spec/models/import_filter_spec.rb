
require 'spec_helper'

describe Models::ImportFilter do
  before(:each) do
    Models::ImportFilter.clear
  end

  it "returns a string of all active filters" do
    Models::ImportFilter.create(:name1, 'Text1')
    Models::ImportFilter.create(:name2, 'Text2')
    Models::ImportFilter.enable :name1
    Models::ImportFilter.enable :name2

    result = Models::ImportFilter.all_names_as_string(", ")
    expect(result).to eq("name1, name2")

    result = Models::ImportFilter.all_names_as_string
    expect(result).to eq("name1, name2")
  end

  it "finds all available filter" do
    Models::ImportFilter.init
    filter = Models::ImportFilter.find(name: :yaml)
    expect(filter.name).to eq(:yaml)
  end

  it "raises an error if an import filter is invalid: name error" do
    test_class = Class.new( Models::ImportFilter ) do

      def self.model_name
        "ImportFilters"
      end

      def self.path_to_instances
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
      def self.model_name
        "ImportFilters"
      end

      def self.path_to_instances
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
      def self.model_name
        "ImportFilters"
      end

      def self.path_to_instances
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

  it "is default that all found filters are disabled" do
    Models::ImportFilter.init
    all_filter = Models::ImportFilter.all
    all_not_enabled_filter = Models::ImportFilter.find_all(enabled: false)
    expect(all_filter.size).to eq(all_not_enabled_filter.size)
  end

  it "enables a filter by request" do
    Models::ImportFilter.init
    Models::ImportFilter.enable(:yaml)
    all_enabled_filter = Models::ImportFilter.find_all( enabled: true )
    filter = Models::ImportFilter.find( :yaml )

    expect( all_enabled_filter ).to eq( [ filter ] )
  end

  it "s find method supports a hash based syntax" do
    Models::ImportFilter.init
    Models::ImportFilter.enable(:yaml)

    enabled_filter = Models::ImportFilter.find(name: :yaml, enabled: true)
    expect(enabled_filter.name).to eq(:yaml)
  end

  it "s find method supports a symbol based syntax as well. The search string is compared against the name method." do
    Models::ImportFilter.init
    enabled_filter = Models::ImportFilter.find(:yaml)
    expect(enabled_filter.name).to eq(:yaml)

    enabled_filter = Models::ImportFilter.find_all(:yaml)
    expect(enabled_filter.first.name).to eq(:yaml)
  end

  it "s find method supports a string based syntax as well. The search string is compared against the name method." do
    Models::ImportFilter.init
    enabled_filter = Models::ImportFilter.find('yaml')
    expect(enabled_filter.name).to eq(:yaml)

    enabled_filter = Models::ImportFilter.find_all('yaml')
    expect(enabled_filter.first.name).to eq(:yaml)
  end

  it "raises an error if an unknown search criteria is used" do
    Models::ImportFilter.init
    expect { 
      enabled_filter = Models::ImportFilter.find(unknown: 'yaml')
    }.to raise_error Exceptions::InvalidSearchCriteria
  end
end
