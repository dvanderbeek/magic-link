$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "magic/link/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "magic-link"
  s.version     = Magic::Link::VERSION
  s.authors     = ["David Van Der Beek"]
  s.email       = ["earlynovrock@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Magic::Link."
  s.description = "TODO: Description of Magic::Link."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
end
