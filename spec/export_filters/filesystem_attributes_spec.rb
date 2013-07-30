require 'spec_helper'

require 'puppet_generator/export_filters/filesystem_attributes'

describe ExportFilters::FilesystemAttributes do

  context "#convert" do
    it "takes the filesystem information and adds it to the given objects" do

      file = create_file 'test_file'

      task = double('Task')
      task.stub(:meta).and_return( {} )
      task.stub(:body).and_return( [ { name: file } ] )

      filter = ExportFilters::FilesystemAttributes.new
      result = []
      switch_to_working_directory do
        result = filter.convert( task.body, task.meta )
      end

      expect( result ).to eq([{:name=>file, :type=>"file", :owner=>ENV['USER'], :mode=>"100644"}])
    end
  end
end
