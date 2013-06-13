#encoding: utf-8
$LOAD_PATH << File.expand_path( '../../lib', __FILE__ )

Dir.glob( File.expand_path( '../support/*.rb', __FILE__ ) ).each { |f| require f }

require 'puppet_generator'
include PuppetGenerator

#FeduxOrg::Stdlib.logger.mode = :debug

