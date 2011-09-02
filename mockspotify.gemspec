# -*- encoding: utf-8 -*-
libpath = File.expand_path('../lib', __FILE__)
$:.unshift libpath unless $:.include?(libpath)
require 'mockspotify/version'

Gem::Specification.new do |gem|
  gem.name     = "mockspotify"
  gem.summary  = %Q{FFI bindings to the mockspotify C library}
  gem.homepage = "https://github.com/Burgestrand/mockspotify"
  gem.authors  = ["Kim Burgestrand"]
  gem.email    = 'kim@burgestrand.se'

  gem.files         = `git ls-files`.split("\n")
  gem.files        += `cd ext/libmockspotify && git ls-files src/`.split("\n").map { |path| "ext/libmockspotify/#{path}" }
  gem.executables   = []
  gem.require_paths = ["lib"]
  gem.extensions    << 'ext/extconf.rb'

  gem.add_dependency 'spotify'

  gem.version     = Spotify::Mock::VERSION
  gem.platform    = Gem::Platform::RUBY
end
