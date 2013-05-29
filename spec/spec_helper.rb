$LOAD_PATH << File.expand_path( '../../lib', __FILE__ )

require 'pry'

require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'rspec'

require 'puppet_generator'
include PuppetGenerator

