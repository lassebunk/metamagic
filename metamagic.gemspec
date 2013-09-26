# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metamagic/version'

Gem::Specification.new do |spec|
  spec.name          = "metamagic"
  spec.version       = Metamagic::VERSION
  spec.authors       = ["Lasse Bunk"]
  spec.email         = ["lassebunk@gmail.com"]
  spec.description   = %q{Metamagic is a simple Ruby on Rails plugin for creating meta tags.}
  spec.summary       = %q{Simple Ruby on Rails plugin for creating meta tags.}
  spec.homepage      = "http://github.com/lassebunk/metamagic"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 3.0.0"
  
  spec.add_development_dependency "sqlite3"
end