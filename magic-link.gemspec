$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "magic/link/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "magic-link"
  s.version     = Magic::Link::VERSION
  s.authors     = ["David Van Der Beek"]
  s.email       = ["earlynovrock@gmail.com"]
  s.homepage    = "https://github.com/dvanderbeek/magic-link"
  s.summary     = "Devise magic sign in links"
  s.description = "Devise magic sign in links"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.2"
  s.add_dependency "devise", ">= 4"

  s.add_development_dependency "sqlite3"
end
