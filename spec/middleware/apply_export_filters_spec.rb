require 'spec_helper'

describe PuppetGenerator::Middleware::ApplyExportFilters do

  before(:all) {
    Models::ExportFilter.init
  }
  
  it "runs multiple filters" do
    task = double('task')
    task.stub(:body).and_return( [ { name: 'abcd' } ])
    task.stub(:meta).and_return( { requested_export_filter: :filesystem_attributes } )
    task.should_receive(:body=)

    app = double('app')
    app.stub(:call)
    ###weiter


    mw = PuppetGenerator::Middleware::ApplyExportFilters.new(app)
    result = mw.call(task)

    expect(result).to eq('')

  end

end
