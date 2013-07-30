require 'spec_helper'

describe Models::View do
  before(:each) {
    Models::View.clear
  }

  context "#init" do
    it "finds all available views" do
      Models::View.init
      expect(Models::View.all.size).to eq(3)
    end
  end

  context "#new" do
    it "has a name based on resource, verb and supported input" do
      test_klass = Class.new( Models::View ) do

        def self.path_to_instances
          File.join( examples_dir, 'models', 'view' , 'test' , '*.erb' )
        end

      end

      test_klass.init
      expect( test_klass.find(name: :show_test_many) ).to_not be_nil
    end
  end

  context "#find" do
    it "can be found via verb" do
      test_klass = Class.new( Models::View ) do

        def self.path_to_instances
          File.join( examples_dir, 'models', 'view' , 'test' , '*.erb' )
        end

      end

      test_klass.init
      expect( test_klass.find(verb: :show ) ).to_not be_nil
    end

    it "can be found via resource" do
      test_klass = Class.new( Models::View ) do

        def self.path_to_instances
          File.join( examples_dir, 'models', 'view' , 'test' , '*.erb' )
        end

      end

      test_klass.init
      expect( test_klass.find(resource: :test ) ).to_not be_nil
    end

    it "can be found via supported_input" do
      test_klass = Class.new( Models::View ) do

        def self.path_to_instances
          File.join( examples_dir, 'models', 'view' , 'test' , '*.erb' )
        end

      end

      test_klass.init
      expect( test_klass.find(supports_enum_as_input: true ) ).to_not be_nil
    end
  end

  context "#render" do
    it "renders the output of a single item view" do
      output_object = double('OutputObject')
      output_object.stub(:suggested_file_name).and_return('/path/to/object')
      output_object.stub(:name).and_return('my_name')
      output_object.stub(:module_name).and_return('my_module')
      output_object.stub(:class_name).and_return('my_class')
      output_object.stub(:path).and_return('/path/')
      output_object.stub(:type).and_return('file')
      output_object.stub(:source).and_return(nil)
      output_object.stub(:owner).and_return('test')
      output_object.stub(:mode).and_return('0700')

      test_klass = Class.new( Models::View ) do
        def self.path_to_instances
          File.join( examples_dir, 'models', 'view' , 'test' , '*.erb' )
        end
      end

      test_klass.init
      definition = test_klass.find(name: :show_test_one).render([ output_object ]).first
      expect( definition.text ).to include("my_module::my_name")
    end

    it "renders the output of a multi item view" do
      output_object = double('OutputObject')
      output_object.stub(:suggested_file_name).and_return('/path/to/object')
      output_object.stub(:name).and_return('my_name')
      output_object.stub(:module_name).and_return('my_module')
      output_object.stub(:class_name).and_return('my_class_name')
      output_object.stub(:path).and_return('/path/')
      output_object.stub(:type).and_return('file')
      output_object.stub(:source).and_return(nil)
      output_object.stub(:owner).and_return('test')
      output_object.stub(:mode).and_return('0700')

      test_klass = Class.new( Models::View ) do
        def self.path_to_instances
          File.join( examples_dir, 'models', 'view' , 'test' , '*.erb' )
        end
      end

      test_klass.init
      definition = test_klass.find(name: :show_test_many).render([ output_object ]).first
      expect( definition.text ).to include("my_module::my_class")
    end
    it "rescues error during rendering" do
      output_object = double('OutputObject')

      test_klass = Class.new( Models::View ) do
        def self.path_to_instances
          File.join( examples_dir, 'models', 'view' , 'test' , '*.erb' )
        end
      end

      test_klass.init
      expect {
        test_klass.find(name: :show_test_many).render([ output_object ])
      }.to raise_error PuppetGenerator::Exceptions::InvalidTemplate
    end
  end

  #it "raises an error if an action is invalid: missing method \"run\"" do
  #  test_klass = Class.new( Models::View ) do

  #    def self.path_to_instances
  #      File.join( examples_dir, 'models', 'view' )
  #    end

  #  end

  #  expect {
  #    test_klass.init
  #  }.to raise_error Exceptions::InvalidAction
  #end
end
