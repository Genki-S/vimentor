# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vimentor/version'

Gem::Specification.new do |gem|
  gem.name          = "vimentor"
  gem.version       = Vimentor::VERSION
  gem.authors       = ["Genki"]
  gem.email         = ["cfhoyuk.reccos.nelg@gmail.com"]
  gem.description   = %q{More than vimtutor}
  gem.summary       = %q{Help you be much more efficient with Vim!}
  gem.homepage      = ""

  gem.add_dependency "thor"
  gem.add_dependency "facets"
  gem.add_dependency "rserve-client"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
