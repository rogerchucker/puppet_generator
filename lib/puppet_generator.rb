require 'erb'
require 'erubis'
require 'middleware'
require 'find'
require 'logger'
require 'pathname'
require 'ansi'
require 'etc'
require 'psych'
require 'fileutils'
#require 'hirb'
require 'forwardable'
require 'set'
#require 'active_support/core_ext/object/blank'

require 'puppet_generator/version'
require 'puppet_generator/exceptions'
require 'puppet_generator/logger'

require 'puppet_generator/models/base'
require 'puppet_generator/models/error_message'
require 'puppet_generator/models/import_filter'
require 'puppet_generator/models/action'
require 'puppet_generator/models/template'

require 'puppet_generator/input_file'
require 'puppet_generator/input_directory'
require 'puppet_generator/input_stdin'

require 'puppet_generator/output_directory'
require 'puppet_generator/output_file'
require 'puppet_generator/output_stdout'

require 'puppet_generator/setup/bare'
require 'puppet_generator/setup/default'
require 'puppet_generator/setup/file'
require 'puppet_generator/setup/package'
require 'puppet_generator/setup/user'
require 'puppet_generator/setup/module'

require 'puppet_generator/puppet_package'
require 'puppet_generator/puppet_file'
require 'puppet_generator/puppet_user'

require 'puppet_generator/templates/class_package'
require 'puppet_generator/templates/single_package'
require 'puppet_generator/templates/class_file'
require 'puppet_generator/templates/single_file'
require 'puppet_generator/templates/class_user'
require 'puppet_generator/templates/single_user'

require 'puppet_generator/filter/null'
require 'puppet_generator/filter/passwd'
require 'puppet_generator/filter/filesystem_attributes'
require 'puppet_generator/filter/yaml'

require 'puppet_generator/actions/null'
require 'puppet_generator/actions/copy_files_to_module_directory'

require 'puppet_generator/definition'
require 'puppet_generator/task'
require 'puppet_generator/middleware/handle_errors'
require 'puppet_generator/middleware/check_for_empty_source'
require 'puppet_generator/middleware/read_input_helper'
require 'puppet_generator/middleware/read_input_files'
require 'puppet_generator/middleware/read_input_packages'
require 'puppet_generator/middleware/entry_to_package'
require 'puppet_generator/middleware/entry_to_user'
require 'puppet_generator/middleware/entry_to_file'
require 'puppet_generator/middleware/create_output'
require 'puppet_generator/middleware/configure_logging'
require 'puppet_generator/middleware/filter_imported_data'
require 'puppet_generator/middleware/create_module_directories'
require 'puppet_generator/middleware/execute_actions'
require 'puppet_generator/middleware/output_debug_information_for_models'
require 'puppet_generator/api'


module PuppetGenerator
  def self.logger
    @logger ||= Logger.new
  end
end
