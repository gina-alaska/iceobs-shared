# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require File.expand_path 'lib/assist_shared/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Scott Macfarlane"]
  gem.email         = ["scott@gina.alaska.edu"]
  gem.summary       = %q{ASSIST Shared Modules}
  gem.description   = %q{ASSIST is a sea ice observation app}
  gem.homepage      = "http://github.com/gina-alaska/iceobs-shared.git"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "assist-shared"
  gem.require_paths = ["lib"]
  gem.version       = AssistShared::VERSION

end