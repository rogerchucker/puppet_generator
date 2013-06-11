require 'spec_helper'

describe PuppetGenerator::Middleware::ExecuteActions do

  before(:all) {
    Models::Action.init
  }
  
  it "run action" do
    test_file = File.join( examples_dir, 'execute_actions', 'file.txt' )
    user = ENV['USER']

    task = double( 'task' )
    task.stub( :body ).and_return( [ { name: test_file } ])
    task.stub( :meta ).and_return( { requested_actions: [ :copy_files_to_module_directory ], module: 'test' } )
    task.should_receive( :body= ).with( [ { :name => File.expand_path('../../examples/execute_actions/file.txt', __FILE__ ), :source => "puppet:///modules/test#{File.expand_path('../../examples/execute_actions/file.txt', __FILE__ )}" } ] )

    app = double('app')
    app.stub(:call)

    mw = PuppetGenerator::Middleware::ExecuteActions.new(app)

    switch_to_working_directory do
      result = mw.call(task)
    end
  end

#  it "run multiple filters" do
#    test_file = File.join( examples_dir, 'apply_export_filters', 'file.txt' )
#    user = ENV['USER']
#
#    task = double( 'task' )
#    task.stub( :body ).and_return( [ { name: test_file } ])
#    task.stub( :meta ).and_return( { requested_export_filter: [ :filesystem_attributes , :null ] } )
#    task.should_receive( :body= ).with( [ {:name => test_file, :type => "file", :owner => user, :mode => "100644"} ] )
#
#    app = double('app')
#    app.stub(:call)
#
#    mw = PuppetGenerator::Middleware::ApplyExportFilters.new(app)
#    result = mw.call(task)
#  end

end
