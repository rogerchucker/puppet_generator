
require 'spec_helper'

describe Models::Template do

  before(:each) {
    Models::Template.clear
  }

  it "returns a string of all active filters" do
    Models::Template.create(:name1, '/path/text1')
    Models::Template.create(:name2, '/path/text2')

    result = Models::Template.all_names_as_string(", ")
    expect(result).to eq("name1, name2")

    result = Models::Template.all_names_as_string
    expect(result).to eq("name1, name2")
  end

  it "loads all available templates on init" do
    Models::Template.init
    expect(Models::Template.find( name: :package, handles_one_element_only: true ).name).to eq(:package)
  end

  it "raises an error if a template is invalid" do
    test_class = Class.new( Models::Template ) do
      def self.filter
        File.join( examples_dir, 'templates', 'invalid_template.pp.erb' )
      end

    end

    test_class.init

    expect {
      test_class.find(:invalid_template).render('')
    }.to raise_error Exceptions::InvalidTemplate
  end

end
