require 'spec_helper'

describe Models::ImportFilter do
  before(:each) do
    Models::ImportFilter.clear
  end

  it "raises an error if an import filter is invalid: missing method \"convert\"" do
    test_class = Class.new( Models::ImportFilter ) do

      def self.library_name
        "PuppetGenerator"
      end

      def self.model_name
        "ImportFilter"
      end

      def self.path_to_instances
        File.join( examples_dir, 'import_filter', 'missing_method.rb' )
      end

      def self.require_path(name)
        File.join( examples_dir, 'import_filter', 'missing_method' )
      end
    end

    expect {
      test_class.init
    }.to raise_error Exceptions::InvalidImportFilter
  end

end
