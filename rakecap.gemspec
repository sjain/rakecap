# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rakecap/version"

Gem::Specification.new do |s|
  s.name        = "rakecap"
  s.version     = Rakecap::VERSION
  s.authors     = ["Sharad Jain"]
  s.email       = ["shaanjain@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A collection of generic useful rake tasks and capistrano recipes.}
  s.description = %q{A collection of generic useful rake tasks and capistrano recipes.}

  s.rubyforge_project = "rakecap"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
