require 'spec_helper'

describe Models::Exporter do
  before(:each) do
    Models::Exporter.clear
  end

  it "finds all available exporters" do
    Models::Exporter.init
    filter = Models::Exporter.find(:file)
    expect(filter.name).to eq(:file)
  end

  it "finds all default exporters" do
    Models::Exporter.init
    Setup::DefaultExporter.use

    filters = Models::Exporter.find_all(enabled: true)
    expect(filters.size).to eq(3)
  end

  it "raises an error if an exporter is invalid: missing method \"write\"" do
    test_class = Class.new( Models::Exporter ) do

      def self.library_name
        "PuppetGenerator"
      end

      def self.model_name
        "Exporter"
      end

      def self.path_to_instances
        File.join( examples_dir, 'exporter', 'missing_method.rb' )
      end

      def self.require_path(name)
        File.join( examples_dir, 'exporter', 'missing_method' )
      end
    end

    expect {
      test_class.init
    }.to raise_error Exceptions::InvalidExporter
  end

  it "finds an exporter for a file" do
    Models::Exporter.init

    expected_result = Models::Exporter.find( :file )
    result = Models::Exporter.find( writes_to: 'file:' + File.join(examples_dir, 'exporter', 'test_file.txt' ) )
    expect(result).to eq(expected_result)
  end

  it "finds an exporter for a directory" do
    Models::Exporter.init

    expected_result = Models::Exporter.find( :directory )
    result = Models::Exporter.find( writes_to: 'dir:' + File.join(examples_dir, 'exporter', 'test.d' ) )
    expect(result).to eq(expected_result)
  end

  it "finds an exporter for stdout" do
    Models::Exporter.init

    expected_result = Models::Exporter.find( :stdout )
    result = Models::Exporter.find( writes_to: 'stdout' )
    expect(result).to eq(expected_result)
  end

end
