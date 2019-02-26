require_relative './lib/utils/strings.rb'

Gem::Specification.new do |s|
  s.name = "railspp"
  s.version = MoreUtils.gem_version
  s.executables = 'railspp'
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Layne Faler"]
  s.description = %q{Scaffolding your CRUD operations}
  s.date = %q{2019-01-01}
  s.email = %q{laynefaler@gmail.com}
  s.files = Dir["{lib,bin}/**/**"] + ["README.md"]
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 2.5"
  s.summary = %q{Scaffold your CRUD operations}

  s.add_runtime_dependency 'rails', '~> 5'
  s.add_runtime_dependency 'rack-cors', '~> 1'
  s.add_runtime_dependency 'faker', '~> 1.9' 

end
