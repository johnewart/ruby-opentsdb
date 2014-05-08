# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "opentsdb/version"

Gem::Specification.new do |s|
  s.name        = "opentsdb"
  s.version     = OpenTSDB::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John Ewart"]
  s.email       = ["john@johnewart.net"]
  s.homepage    = "https://github.com/johnewart/ruby-opentsdb"
  s.summary     = %q{Ruby client for OpenTSDB}
  s.description = %q{A Ruby implementation of a client library for sending data points to OpenTSDB}
  s.license     = 'MIT'

  s.rubyforge_project = "opentsdb"

  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov", [">= 0.3.8"] #, :require => false

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
