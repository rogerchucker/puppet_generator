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

  it "finds all default filter" do
    Models::Importer.init
    Setup::DefaultImporter.use

    filters = Models::Importer.find_all(enabled: true)
    expect(filters.size).to eq(3)
  end

  it "raises an error if an importer is invalid: missing method \"read\"" do
    test_class = Class.new( Models::Importer ) do

      def self.model_name
        "Importers"
      end

      def self.path_to_instances
        File.join( examples_dir, 'importer', 'missing_method.rb' )
      end

      def self.require_path(name)
        File.join( examples_dir, 'importer', 'missing_method' )
      end
    end

    expect {
      test_class.init
    }.to raise_error Exceptions::InvalidImporter
  end

  it "finds an importer for a file" do
    Models::Importer.init

    expected_result = Models::Importer.find( :file )
    result = Models::Importer.find( reads_from: File.join(examples_dir, 'importer', 'test_file.txt' ) )
    expect(result).to eq(expected_result)
  end

  it "finds an importer for a directory" do
    Models::Importer.init

    expected_result = Models::Importer.find( :directory )
    result = Models::Importer.find( reads_from: File.join(examples_dir, 'importer', 'test.d' ) )
    expect(result).to eq(expected_result)
  end

  it "finds an importer for stdin" do
    Models::Importer.init

    expected_result = Models::Importer.find( :stdin )
    result = Models::Importer.find( reads_from: 'stdin' )
    expect(result).to eq(expected_result)
  end

  it "reads from file" do
    Models::Importer.init

    importer = Models::Importer.find( :file )
    result = importer.read(File.join(examples_dir, 'importer', 'test_file.txt' ))
    expect(result).to eq([ 'asdf' ] )
  end

end

