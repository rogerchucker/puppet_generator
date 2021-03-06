require 'spec_helper'

describe PuppetGenerator::Middleware::ApplyExportFilters do

  before(:all) {
    Models::ExportFilter.init
  }
  
  it "run filter" do
    test_file = File.join( examples_dir, 'apply_export_filters', 'file.txt' )
    FileUtils.chmod(0644, test_file )

    user = ENV['USER']

    task = double( 'task' )
    task.stub( :body ).and_return( [ { name: test_file } ])
    task.stub( :meta ).and_return( { requested_export_filter: [ :filesystem_attributes ] } )
    task.should_receive( :body= ).with( [ {:name => test_file, :type => "file", :owner => user, :mode => "100644"} ] )

    app = double('app')
    app.stub(:call)

    mw = PuppetGenerator::Middleware::ApplyExportFilters.new(app)
    result = mw.call(task)
  end

  it "run multiple filters" do
    test_file = File.join( examples_dir, 'apply_export_filters', 'file.txt' )
    FileUtils.chmod(0644, test_file )

    user = ENV['USER']

    task = double( 'task' )
    task.stub( :body ).and_return( [ { name: test_file } ])
    task.stub( :meta ).and_return( { requested_export_filter: [ :filesystem_attributes , :null ] } )
    task.should_receive( :body= ).with( [ {:name => test_file, :type => "file", :owner => user, :mode => "100644"} ] )

    app = double('app')
    app.stub(:call)

    mw = PuppetGenerator::Middleware::ApplyExportFilters.new(app)
    result = mw.call(task)
  end

end
