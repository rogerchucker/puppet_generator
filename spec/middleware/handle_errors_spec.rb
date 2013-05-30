require 'spec_helper'

describe PuppetGenerator::Middleware::HandleErrors do

  it "raises an exception if error message is unknown" do
    mw = PuppetGenerator::Middleware::HandleErrors.new('asdf')
    expect {
      mw.send(:exit_with_error, :asdf)
    }.to raise_error Exceptions::UnknownErrorMessage
  end

end
