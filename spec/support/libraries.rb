unless ENV['TRAVIS_CI'] == 'true'
  require 'pry'
  require 'debugger'
  require 'ap'
  require 'benchmark'

  require 'simplecov'
  SimpleCov.start
  SimpleCov.command_name 'rspec'
end
