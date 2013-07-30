def examples_dir
  File.expand_path( '../../examples', __FILE__ )
end

require 'fedux_org/stdlib/filesystem'
include FeduxOrg::Stdlib::Filesystem

def root_directory
  File.expand_path( '../../../', __FILE__ )
end

RSpec.configure do |c|
  c.before(:each) do 
    delete_working_directory
    create_working_directory  
  end
end
