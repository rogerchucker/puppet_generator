require 'spec_helper'

require 'puppet_generator/export_filters/puppet_meta_information'

describe ExportFilters::PuppetMetaInformation do

  context "#convert" do
    it "returns includes for directory" do
      task = double(:task)
      task.stub(:meta).and_return( { module: 'asdf', class: 'asdf' } )
      task.stub(:body).and_return( [
        { name: 'asdf' },
        { name: 'blub' },
      ] )

      result = ExportFilters::PuppetMetaInformation.new.convert( task.body, task.meta )
      expected_result = [
        {:name=>"asdf", :module=>"asdf", :class=>"asdf"},
        {:name=>"blub", :module=>"asdf", :class=>"asdf"}
      ]

      expect(result).to eq(expected_result)
    end
  end
end
