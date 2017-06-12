#!/usr/bin/ruby -w
# -*- ruby -*-

require 'cmdline/tc'
require 'cmdline/cachefile'

Logue::Log.level = Logue::Log::WARN

class CmdLine::CacheFileTestCase < CmdLine::CommandTestCase
  include Logue::Loggable

  def get_cache_file command
    CmdLine::CacheFile.new CACHE_DIR, command
  end

  def rm_cached_file cachefile
    pn = cachefile.pathname
    pn.exist? && pn.unlink
  end
  
  def test_creates_gzfile
    cf = get_cache_file [ "ls", "/var/tmp" ]
    rm_cached_file cf
    assert_false cf.pathname.exist?
    
    output = cf.readlines
    assert cf.pathname.exist?

    fromgz = read_gzfile cf.pathname
    assert_equal output, fromgz
  end

  def test_reads_gzfile
    cf = get_cache_file [ "ls", "-l", "/var/tmp" ]
    rm_cached_file cf
    assert_false cf.pathname.exist?

    execlines = cf.readlines
    assert cf.pathname.exist?

    # same as above
    cf2 = get_cache_file [ "ls", "-l", "/var/tmp" ]
    
    def cf2.save_file
      fail "should not have called save file for read"
    end

    cachedlines = cf2.readlines
    fromgz = read_gzfile cf.pathname
    assert_equal execlines, fromgz
    assert_equal execlines, cachedlines
  end
end
