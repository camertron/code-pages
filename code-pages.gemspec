$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'code-pages/version'

Gem::Specification.new do |s|
  s.name     = 'code-pages'
  s.version  = ::CodePages::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/camertron/code-pages'

  s.description = s.summary = 'A database of legacy Microsoft and ISO 8859 code pages for Ruby.'

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.require_path = 'lib'
  s.files = Dir['{lib,spec,resources}/**/*', 'Gemfile', 'README.md', 'Rakefile', 'code-pages.gemspec']
end
