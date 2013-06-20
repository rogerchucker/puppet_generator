# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet_generator/version'

Gem::Specification.new do |spec|
  spec.name          = "puppet_generator"
  spec.version       = PuppetGenerator::VERSION
  spec.authors       = ["Max Meyer"]
  spec.email         = ["dev@fedux.org"]
  spec.summary       = %q{Generate puppet manifests}
  spec.description   = <<-DESC
  If you need to build more than one puppet manifests it is quite boring to 
  redo the same steps every time. This gem helps you to generate puppet manifests
  for packages, files/directories etc.
  DESC
  spec.homepage      = "https://github.com/maxmeyer/puppet_generator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "middleware", "~> 0.1.0"
  spec.add_dependency "ansi", "~> 1.4.3"
  spec.add_dependency "erubis", "~> 2.7.0"
  spec.add_dependency "hirb-unicode", "~> 0.0.5"
  #spec.add_dependency "hirb", "~> 0.7.1"
  #spec.add_dependency "logging4hackers"
  spec.add_dependency "activesupport", "~>3.2.13"
  spec.add_dependency "fedux_org-stdlib"
  spec.add_dependency "thor", "~> 0.18.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
