#!/usr/bin/ruby -w
# -*- ruby -*-

require 'system/command/line'
require 'system/command/cachefile'

class System::CachingCommandLine < System::CommandLine
  # caches its input and values.

  @@cache_dir = '/tmp' + Pathname.new($0).expand_path.to_s

  class << self
    def cache_dir
      @@cache_dir
    end

    def cache_dir= dir
      @@cache_dir = dir
    end
  end

  def cache_dir
    @@cache_dir
  end

  def cache_file
    System::CacheFile.new cache_dir, @args
  end

  def execute
    cachefile = cache_file
    @output = cachefile.readlines
  end
end
