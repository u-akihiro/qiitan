# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qiitan/version'

Gem::Specification.new do |spec|
  spec.name          = "qiitan"
  spec.version       = Qiitan::VERSION
  spec.authors       = ["akihiro"]
  spec.email         = ["cp2xlrun@gmail.com"]
  spec.summary       = %q{qiita api wrapper}
  spec.description   = %q{simple wrapper library for qiita api}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
	spec.add_development_dependency "rspec", "2.14.1"
end
