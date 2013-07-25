require 'spec_helper'

require 'puppet_generator/setups/create_file'

describe Setups::CreateFile do

  let(:setup) { Setups::CreateFile.new }

  before(:each) {
    Models::Default.clear
    Models::Default.init

    Models::Action.clear
    Models::EntryConverter.clear
    Models::ErrorMessage.clear
    Models::Exporter.clear
    Models::ExportFilter.clear
    Models::Importer.clear
    Models::ImportFilter.clear
    Models::Template.clear
    Models::View.clear
  }

  context "#description" do
    it "has a description" do
      expect( setup.description ).to_not eq(nil)
    end
  end

  context "#environment" do
    it "enables all defaults" do
      setup.environment

      expect( name_of_model_instances(:error_message)).to eq( [
        :copy_error,
        :empty_source,
        :filesystem_error,
        :internal_error,
        :interrupt,
        :invalid_output_channel,
        :invalid_passwd_input,
        :invalid_source,
        :invalid_yaml_input,
        :unknown_action,
        :unknown_import_filter,
        :wrong_template_chosen,
      ])

      expect( name_of_model_instances(:import_filter)).to eq([:null, :yaml])

      expect( name_of_model_instances(:action)).to eq([:null])
            
      expect( name_of_model_instances(:importer)).to eq([:directory,
                                                         :file,
                                                         :stdin])

      expect( name_of_model_instances(:export_filter)).to eq([:copy_files_to_module_directory,
                                                              :filesystem_attributes,
                                                              :null,
                                                              :puppet_meta_information])

      expect( name_of_model_instances(:exporter)).to eq([])
    end
  end
  
end
