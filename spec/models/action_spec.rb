require 'spec_helper'

describe Models::Action do
  before(:each) {
    Models::Action.clear
  }

  it "finds all available actions" do
    Models::Action.init
    expect(Models::Action.all.size).to eq(1)
  end

  it "raises an error if an action is invalid: missing method \"run\"" do
    test_class = Class.new( Models::Action ) do

      def self.library_name
        "PuppetGenerator"
      end

      def self.model_name
        "Exporters"
      end

      def self.path_to_instances
        File.join( examples_dir, 'action', 'missing_method.rb' )
      end

      def self.require_path(name)
        File.join( examples_dir, 'action', 'missing_method' )
      end
    end

    expect {
      test_class.init
    }.to raise_error Exceptions::InvalidAction
  end
end
