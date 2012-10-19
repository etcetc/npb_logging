# -*- encoding: utf-8 -*-
require File.expand_path('../lib/npb_logging/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["etcetc"]
  gem.email         = ["ff@onebeat.com"]
  gem.description   = %q{Just a different way of logging}
  gem.summary       = %q{This gem modifies the rails logging mechanisms to allow access to sessions.  If the session has a user_id, it adds it to the log lines.  It also adds any log notes.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "npb_logging"
  gem.require_paths = ["lib"]
  gem.version       = NpbLogging::VERSION
end
