$LOAD_PATH << File.expand_path( '../../../lib' , __FILE__ )

require 'pry' unless ENV['TRAVIS_CI'] == 'true' 
require 'aruba/cucumber'

#require 'simplecov'
#SimpleCov.start
