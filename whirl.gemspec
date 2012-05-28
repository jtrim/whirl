# -*- encoding: utf-8 -*-
require File.expand_path('../lib/whirl/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jesse Trimble"]
  gem.email         = ["jlowelltrim@gmail.com"]
  gem.description   = %q{A watered-down task runner pre-wired with Redis. Built with Heroku Cedar in mind.}
  gem.summary       = %q{A watered-down task runner pre-wired with Redis. Built with Heroku Cedar in mind.}
  gem.homepage      = ""

  gem.add_dependency 'thor'
  gem.add_dependency 'httparty'
  gem.add_dependency 'redis'

  gem.add_development_dependency 'rspec'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "whirl"
  gem.require_paths = ["lib"]
  gem.version       = Whirl::VERSION
end
