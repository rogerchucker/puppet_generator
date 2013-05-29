#encoding: utf-8
$LOAD_PATH << File.expand_path( '../../lib', __FILE__ )

unless ENV['TRAVIS_CI'] == 'true'
  require 'pry'
  require 'debugger'
  require 'ap'
  require 'benchmark'
end

unless ENV['TRAVIS_CI'] == 'true'
  require 'simplecov'
  SimpleCov.start
  SimpleCov.command_name 'rspec'
end

require 'puppet_generator'
include PuppetGenerator

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.filter_run :focus => true
  c.run_all_when_everything_filtered = true
end
