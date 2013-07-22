require 'spec_helper'

describe Setups::Base do

  before(:each) {
    Models::Default.init
  }

  context "#enable_defaults_for" do
    it "enable instances of a given model which should be enabled by default" do
      klass = Class.new(Setups::Base) do
        def environment
          use_defaults_for :action
        end
      end
      klass.new.environment
      expect( Models::Action.find_all( enabled: true ).size ).to be > 0
    end

    it "raises an error if a default cannot be found for the given model" do
      klass = Class.new(Setups::Base) do
        def environment
          use_defaults_for :unknown_model
        end
      end

      expect {
        klass.new.environment
      }.to raise_error Exceptions::UnknownSetup

    end
  end

  context "#enable_all_of" do
    it "enables all available instances of a model" do
      klass = Class.new(Setups::Base) do
        def environment
          enable_all_of :entry_converter
        end
      end
      klass.new.environment
      expect( Models::EntryConverter.find_all( enabled: true ).size ).to be > 0
    end

    it "supports the use of a string as well" do
      klass = Class.new(Setups::Base) do
        def environment
          enable_all_of 'entry_converter'
        end
      end
      klass.new.environment
      expect( Models::EntryConverter.find_all( enabled: true ).size ).to be > 0
    end

    it "raises an error if no valid model can be found" do
      klass = Class.new(Setups::Base) do
        def environment
          enable_all_of :unknown
        end
      end
      expect {
        klass.new.environment
      }.to raise_error PuppetGenerator::Exceptions::UnknownModel
    end

    it "raises an error if no valid model instances can be found" do
      class ::PuppetGenerator::Models::DysFunctionalModel
        def self.path_to_instances
          ''
        end

        def self.suffix
          ''
        end
      end
      
      klass = Class.new(Setups::Base) do
        def environment
          enable_all_of :dys_functional_model
        end
      end
      expect {
        klass.new.environment
      }.to raise_error PuppetGenerator::Exceptions::MissingModelInstances
    end
  end

  context "#enable_action" do
    it "enables an action" do
      klass = Class.new(Setups::Base) do
        def environment
          enable_action :null
        end
      end
      klass.new.environment
      expect( Models::Action.find( name: :null ).enabled? ).to be_true
    end
  end

  context "#enable_import_filter" do
    it "enables an import filter" do
      klass = Class.new(Setups::Base) do
        def environment
          enable_import_filter :null
        end
      end
      klass.new.environment
      expect( Models::ImportFilter.find( name: :null ).enabled? ).to be_true
    end
  end

  context "#enable_importer" do
    it "enables an importer" do
      klass = Class.new(Setups::Base) do
        def environment
          enable_importer :file
        end
      end
      klass.new.environment
      expect( Models::Importer.find( name: :file ).enabled? ).to be_true
    end
  end
  
  context "#enable_exporter" do
    it "enables an exporter" do
      klass = Class.new(Setups::Base) do
        def environment
          enable_exporter :file
        end
      end
      klass.new.environment
      expect( Models::Exporter.find( name: :file ).enabled? ).to be_true
    end
  end

  context "#enable_export_filter" do
    it "enables an export filter" do
      klass = Class.new(Setups::Base) do
        def environment
          enable_export_filter :puppet_meta_information
        end
      end
      klass.new.environment
      expect( Models::ExportFilter.find( name: :puppet_meta_information ).enabled? ).to be_true
    end
  end

  context "#enable_items_for" do
    it "enables multiple items given as array " do
      klass = Class.new(Setups::Base) do
        def environment
          enable_items_for Models::ImportFilter, [ :null, :passwd ]
        end
      end
      klass.new.environment
      expect( Models::ImportFilter.find_all( enabled: true ).size ).to eq(2)
    end

    it "enables multiple import filter as arguments" do
      klass = Class.new(Setups::Base) do
        def environment
          enable_items_for Models::ImportFilter, :null, :passwd
        end
      end
      klass.new.environment
      expect( Models::ImportFilter.find_all( enabled: true ).size ).to eq(2)
    end
  end
end
