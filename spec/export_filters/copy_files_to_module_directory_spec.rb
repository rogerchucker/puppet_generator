require 'spec_helper'

require 'puppet_generator/export_filters/copy_files_to_module_directory'

describe ExportFilters::CopyFilesToModuleDirectory do

  context "#convert" do
    it "copies files to module directory" do

      file = create_file 'test_file'

      task = double('Task')
      task.stub(:meta).and_return( {} )
      task.stub(:body).and_return( [ { module: 'asdf', name: file } ] )

      filter = ExportFilters::CopyFilesToModuleDirectory.new
      result = []
      switch_to_working_directory do
        result = filter.convert( task.body, task.meta )
      end

      expect( result ).to eq([{:module=>"asdf", :name=>file, :source=>"puppet:///modules/asdf#{file}"}])
    end
  end
end
