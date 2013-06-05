require 'spec_helper'

describe Models::ExportFilter do

  it "finds all available filter" do
    Models::ExportFilter.init
    filter = Models::ExportFilter.find(:null)
    expect(filter.name).to eq(:null)
  end

  it "raises an error if an export filter is invalid: name error" do
    test_class = Class.new( Models::ExportFilter ) do

      def self.model_name
        "ExportFilters"
      end

      def self.path_to_instances
        File.join( examples_dir, 'export_filter', 'invalid_filter_1.rb' )
      end

      def self.require_path(name)
        File.join( examples_dir, 'export_filter', 'invalid_filter_1' )
      end
    end

    expect {
      test_class.init
    }.to raise_error Exceptions::InvalidExportFilter
  end

  it "raises an error if an export filter is invalid: missing method" do
    test_class = Class.new( Models::ExportFilter ) do
      def self.model_name
        "ExportFilters"
      end

      def self.path_to_instances
        File.join( examples_dir, 'export_filter', 'invalid_filter_2.rb' )
      end

      def self.require_path(name)
        File.join( examples_dir, 'export_filter', 'invalid_filter_2' )
      end
    end

    expect {
      test_class.init
    }.to raise_error Exceptions::InvalidExportFilter
  end

end
