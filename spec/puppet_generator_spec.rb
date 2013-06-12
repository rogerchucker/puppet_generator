require 'spec_helper'

describe PuppetGenerator do
  it "has a gem load path" do
    expect(PuppetGenerator.gem_load_path).to eq('puppet_generator')
  end
end
