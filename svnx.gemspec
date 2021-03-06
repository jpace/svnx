# coding: utf-8
lib = File.expand_path '../lib', __FILE__
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib
require 'svnx/version'

Gem::Specification.new do |spec|
  spec.name          = "svnx"
  spec.version       = Svnx::VERSION
  spec.authors       = ["Jeff Pace"]
  spec.email         = ["jeugenepace@gmail.com"]

  spec.summary       = %q{Ruby objects from the Subversion command line}
  spec.description   = %q{Bridges the Subversion command line, returning Ruby objects.}
  spec.homepage      = "https://github.com/jpace/svnx"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to? :metadata
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match %r{^(test|spec|features)/} }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename f }
  spec.require_paths = ["lib"]

  spec.add_dependency "command-cacheable", "~> 0.2"
  spec.add_dependency "logue", ">= 1.0.16"
  spec.add_dependency "nokogiri", "~> 1.10.3"
  spec.add_dependency "rainbow", "~> 3.0.0"
  
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3.1.5"
  spec.add_development_dependency "paramesan", "~> 0.1.1"
end
