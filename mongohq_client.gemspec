lib = File.expand_path('../lib/', __FILE__)

Gem::Specification.new do |s|
  s.name        = "mongohq-client"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rodrigo Saito"]
  s.email       = ["rodrigo.saito@gmail.com"]
  s.summary     = "A client for MongoHQ API"

  s.add_dependency("httparty")
  s.add_dependency("json")

  s.add_development_dependency("rspec")
  s.add_development_dependency("guard")
  s.add_development_dependency("guard-rspec")
  s.add_development_dependency("fakeweb")

  s.require_path = 'lib'
end

