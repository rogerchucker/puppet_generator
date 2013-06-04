require 'spec_helper'

describe Models::Importer do
  before(:each) do
    Models::Importer.clear
  end

  it "returns a string of all active importer" do
    Models::Importer.create(:name1, 'Text1')
    Models::Importer.create(:name2, 'Text2')
    Models::Importer.enable :name1
    Models::Importer.enable :name2

    result = Models::Importer.all_names_as_string(", ")
    expect(result).to eq("name1, name2")

    result = Models::Importer.all_names_as_string
    expect(result).to eq("name1, name2")
  end

  it "finds all available filter" do
    Models::Importer.init
    filter = Models::Importer.find(:file)
    expect(filter.name).to eq(:file)
  end

#  it "raises an error if an import filter is invalid: name error" do
#    test_class = Class.new( Models::Importer ) do
#
#      def self.model_name
#        "Importers"
#      end
#
#      def self.path_to_instances
#        File.join( examples_dir, 'import_filter', 'invalid_filter_1.rb' )
#      end
#
#      def self.require_path(name)
#        File.join( examples_dir, 'import_filter', 'invalid_filter_1' )
#      end
#    end
#
#    expect {
#      test_class.init
#    }.to raise_error Exceptions::InvalidImporter
#  end
#
#  it "an import filter uses a forbidden keywords as name" do
#    test_class = Class.new( Models::Importer ) do
#      def self.model_name
#        "Importers"
#      end
#
#      def self.path_to_instances
#        File.join( examples_dir, 'import_filter', 'forbidden_keyword.rb' )
#      end
#
#      def self.require_path(name)
#        File.join( examples_dir, 'import_filter', 'forbidden_keyword' )
#      end
#
#      def self.forbidden_keywords
#        [ :forbidden_keyword ]
#      end
#    end
#
#    expect {
#      test_class.init
#    }.to raise_error Exceptions::UnauthorizedUseOfKeyword
#  end
#
#
#  it "raises an error if an import filter is invalid: missing method" do
#    test_class = Class.new( Models::Importer ) do
#      def self.model_name
#        "Importers"
#      end
#
#      def self.path_to_instances
#        File.join( examples_dir, 'import_filter', 'invalid_filter_2.rb' )
#      end
#
#      def self.require_path(name)
#        File.join( examples_dir, 'import_filter', 'invalid_filter_2' )
#      end
#    end
#
#    expect {
#      test_class.init
#    }.to raise_error Exceptions::InvalidImporter
#  end
#
#  it "is default that all found filters are disabled" do
#    Models::Importer.init
#    all_filter = Models::Importer.all
#    all_not_enabled_filter = Models::Importer.find_all(enabled: false)
#    expect(all_filter.size).to eq(all_not_enabled_filter.size)
#  end
#
#  it "enables a filter by request" do
#    Models::Importer.init
#    Models::Importer.enable(:yaml)
#    all_enabled_filter = Models::Importer.find_all( enabled: true )
#    filter = Models::Importer.find( :yaml )
#
#    expect( all_enabled_filter ).to eq( [ filter ] )
#  end
#
#  it "s find method supports a hash based syntax" do
#    Models::Importer.init
#    Models::Importer.enable(:yaml)
#
#    enabled_filter = Models::Importer.find(name: :yaml, enabled: true)
#    expect(enabled_filter.name).to eq(:yaml)
#  end
#
#  it "s find method supports a symbol based syntax as well. The search string is compared against the name method." do
#    Models::Importer.init
#    enabled_filter = Models::Importer.find(:yaml)
#    expect(enabled_filter.name).to eq(:yaml)
#
#    enabled_filter = Models::Importer.find_all(:yaml)
#    expect(enabled_filter.first.name).to eq(:yaml)
#  end
#
#  it "s find method supports a string based syntax as well. The search string is compared against the name method." do
#    Models::Importer.init
#    enabled_filter = Models::Importer.find('yaml')
#    expect(enabled_filter.name).to eq(:yaml)
#
#    enabled_filter = Models::Importer.find_all('yaml')
#    expect(enabled_filter.first.name).to eq(:yaml)
#  end
#
#  it "raises an error if an unknown search criteria is used" do
#    Models::Importer.init
#    expect { 
#      enabled_filter = Models::Importer.find(unknown: 'yaml')
#    }.to raise_error Exceptions::InvalidSearchCriteria
#  end
end

