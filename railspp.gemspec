require_relative './lib/utils/strings.rb'

Gem::Specification.new do |s|
  s.name = "railspp"
  s.version = MoreUtils.gem_version
  s.executables = 'railspp'
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Layne Faler"]
  s.homepage = "https://github.com/laynef/RailsPlusPlus"
  s.description = %q{Scaffolding your CRUD operations}
  s.date = %q{2019-01-01}
  s.email = %q{laynefaler@gmail.com}
  s.files = Dir["{lib,bin}/**/**"] + ["README.md"]
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 2.5"
  s.licenses = 'MIT'
  s.summary = %q{Scaffold your CRUD operations}

  s.add_dependency 'rails', '~> 5'
  s.add_dependency 'faker', '~> 1.9' 
  s.add_dependency 'rack-cors', require: 'rack/cors'

end
