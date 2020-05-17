Gem::Specification.new do |s|
  s.name        = 'rails_init'
  s.version     = '0.0.0'
  s.date        = '2020-05-17'

  s.summary     = 'Rais wizard'
  s.description = 'A simple gem to create new customized Rails projects'

  s.authors     = ['Zsolt Kozaroczy']
  s.email       = 'kiskoza@gmail.com'
  s.homepage    = 'https://github.com/kiskoza/rails-wizard'
  s.license     = 'MIT'

  s.files       = ['lib/rails_init.rb']

  s.add_development_dependency 'byebug', '11.1.3'

  s.add_runtime_dependency 'tty-prompt', '0.21.0'
end
