
require 'spec_helper'

describe Models::Template do

  before(:each) {
    Models::Template.clear
  }

  it "loads all available templates on init" do
    Models::Template.init
    result = Models::Template.find( name: :package, is_suitable_for: :directory )
    expect(result.name).to eq(:package)

    result = Models::Template.find( name: :package, is_suitable_for: :file )
    expect(result.name).to eq(:package)
  end

  it "raises an error if a template is invalid: missing method \"render\"" do
    test_class = Class.new( Models::Template ) do

      def self.library_name
        "PuppetGenerator"
      end

      def self.model_name
        "Template"
      end

      def self.create_tags(path)
        [ :many_per_file ]
      end

      def self.path_to_instances
        File.join( examples_dir, 'templates', 'invalid_template.pp.erb' )
      end

    end

    test_class.init

    expect {
      test_class.first.render( [ :asdf ] )
    }.to raise_error Exceptions::InvalidTemplate
  end

end
