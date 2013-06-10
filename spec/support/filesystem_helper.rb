def examples_dir
  File.expand_path( '../../examples', __FILE__ )
end

require 'fedux_org/stdlib/filesystem'
include FeduxOrg::Stdlib::Filesystem

def root_directory
  File.expand_path( '../../../', __FILE__ )
end

create_working_directory
