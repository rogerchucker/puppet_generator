SimpleCov.start do
  add_filter "/features/"
  add_filter "/spec/"
  add_group "actions", "lib/puppet_generator/actions/"
  add_group "actions", "lib/puppet_generator/filter/"
  add_group "actions", "lib/puppet_generator/templates/"
  add_group "lib", "lib/"
end
