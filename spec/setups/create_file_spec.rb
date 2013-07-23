require 'spec_helper'

require 'puppet_generator/setups/create_file'

describe Setups::CreateFile do

  let(:setup) { Setups::CreateFile.new }

  before(:each) {
    Models::Default.init
  }

  context "#description" do
    it "has a description" do
      expect( setup.description ).to_not eq(nil)
    end
  end

  context "#environment" do
    it "enables all defaults" do
      setup.environment

      expect( name_of_model_instances(:error_message)).to eq( [:invalid_source,
                                                               :invalid_output_channel,
                                                               :empty_source,
                                                               :unknown_import_filter,
                                                               :invalid_yaml_input,
                                                               :invalid_passwd_input,
                                                               :unknown_action,
                                                               :filesystem_error,
                                                               :wrong_template_chosen,
                                                               :copy_error,
                                                               :interrupt,
                                                               :internal_error])

      expect( name_of_model_instances(:import_filter)).to eq([:null, :yaml])

      expect( name_of_model_instances(:action)).to eq([:null])
            
      expect( name_of_model_instances(:importer)).to eq([:directory,
                                                         :file,
                                                         :stdin])

      expect( name_of_model_instances(:export_filter)).to eq([:copy_files_to_module_directory,
                                                              :filesystem_attributes,
                                                              :null,
                                                              :puppet_meta_information])


    end
  end
  
end
