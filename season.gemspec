# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'season/version'

Gem::Specification.new do |spec|
  spec.name          = "season"
  spec.version       = Season::VERSION
  spec.authors       = ["Joao Diogo Costa"]
  spec.email         = ["jdscosta91@gmail.com"]
  spec.summary       = %q{Season automatically creates scopes for your models' datetime columns.}
  spec.description   = %q{Season automatically creates scopes for your models' datetime columns.}
  spec.homepage      = "https://github.com/joaodiogocosta/season"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = Gem::Requirement.new('>= 1.9.3')

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "activerecord", "~> 4.0"
  spec.add_development_dependency "rubocop", "~> 0.29"
  spec.add_development_dependency "rubocop-rspec", "~> 1.2"
  spec.add_development_dependency "sqlite3", "~> 1.3" 
end
