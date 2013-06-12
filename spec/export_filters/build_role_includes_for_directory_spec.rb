require 'spec_helper'

require 'puppet_generator/export_filters/build_role_includes_for_directory'

describe ExportFilters::BuildRoleIncludesForDirectory do

  it "returns includes for directory" do
    create_directory 'test'
    create_file 'test/file1.pp'
    create_file 'test/file2.pp'
    create_file 'test/file3.pp'

    create_directory 'test/dir1'
    create_file 'test/dir1/file1.pp'
    create_file 'test/dir1/file2.pp'
    create_file 'test/dir1/file3.pp'

    objects = [
      {
        name: 'test',
      },
      {
        name: 'test/dir1',
      },
    ]

    switch_to_working_directory do
      filter = ExportFilters::BuildRoleIncludesForDirectory.new
      expect(filter.convert(objects)).to eq(
        [
          {:name=>"test", :includes=>["file1", "file2", "file3"]},
          {:name=>"test/dir1", :includes=>["file1", "file2", "file3"]}
        ]
      )
    end

  end
  
end
