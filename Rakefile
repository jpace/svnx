require 'rubygems'
require 'rake/testtask'
require 'rubygems/package_task'
require 'fileutils'
require './test/resources'
require './lib/svnx'

Dir['tasks/**/*.rake'].each { |t| load t }

task :default => :test

Rake::TestTask.new('test') do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.warning = true
  t.verbose = true
end

task :build_fixtures do
  Resources.instance.generate
end

spec = Gem::Specification.new do |s| 
  s.name               = Svnx::NAME
  s.version            = Svnx::VERSION
  s.author             = "Jeff Pace"
  s.email              = "jeugenepace@gmail.com"
  s.homepage           = "http://github.com/jpace/svnx"
  s.platform           = Gem::Platform::RUBY
  s.summary            = "Wrapper around Subversion command line."
  s.description        = "A bridge between Subversion functionality, via the command line, and Ruby."
  s.files              = FileList["{lib}/**/*"].to_a
  s.require_path       = "lib"
  s.test_files         = FileList["{test}/**/*test.rb"].to_a
  s.has_rdoc           = false
  s.bindir             = 'bin'
  s.license            = 'MIT'

  s.add_dependency "logue",   "~> 1.0"
  s.add_dependency "rainbow", "~> 2.1"
end
 
Gem::PackageTask.new(spec) do |pkg| 
  pkg.need_zip = true 
  pkg.need_tar_gz = true 
end 
