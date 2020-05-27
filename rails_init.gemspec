Gem::Specification.new do |s|
  s.name        = 'rails_init'
  s.version     = '0.1.0'
  s.date        = '2020-05-27'

  s.summary     = 'Rais wizard'
  s.description = 'A simple gem to create new customized Rails projects'

  s.authors     = ['Zsolt Kozaroczy']
  s.email       = 'kiskoza@gmail.com'
  s.homepage    = 'https://github.com/kiskoza/rails-wizard'
  s.license     = 'MIT'

  s.executables << 'rails_init'
  s.files       = Dir["lib/**/*.rb", "bin/*", "LICENSE", "*.md"]

  s.add_development_dependency 'byebug', '11.1.3'

  s.add_runtime_dependency 'tty-prompt', '0.21.0'
end
