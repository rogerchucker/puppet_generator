
require 'spec_helper'

describe Models::Template do

  before(:each) {
    Models::Template.clear
  }

  it "loads all available templates on init" do
    Models::Template.init
    result = Models::Template.find( name: :package, handles_one_element_only: true )
    expect(result.name).to eq(:package)
  end

  it "raises an error if a template is invalid" do
    test_class = Class.new( Models::Template ) do
      def self.path_to_instances
        File.join( examples_dir, 'templates', 'invalid_template.pp.erb' )
      end

    end

    test_class.init

    expect {
      test_class.find(:invalid_template).render('')
    }.to raise_error Exceptions::InvalidTemplate
  end

end
