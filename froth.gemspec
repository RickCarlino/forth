$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.authors = ['Rick Carlino']
  s.description = "Poor man's FORTH interpreter."
  s.email = 'rick.carlino@gmail.com'
  s.files = `git ls-files`.split("\n")
  s.homepage = 'http://github.com/rickcarlino/forth'
  s.license = 'MIT'
  s.name = 'frothy'
  s.require_paths = ['lib']
  s.summary = "Everyone loves FORTH!"
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = '0.0.5'

end