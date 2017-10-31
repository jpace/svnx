#!/usr/bin/ruby -w
# -*- ruby -*-

require 'cmdline/tc'
require 'cmdline/cachefile'
require 'pathname_assertions'

Logue::Log.level = Logue::Log::WARN

module CmdLine
  class CacheFileTestCase < CommandTestCase
    include Logue::Loggable
    include PathnameAssertions

    def get_cache_file command
      CacheFile.new CACHE_DIR, command
    end

    def rm_cached_file cachefile
      pn = cachefile.pathname
      pn.exist? && pn.unlink
    end
    
    def test_creates_gzfile
      cf = get_cache_file [ "ls", "/var/tmp" ]
      rm_cached_file cf
      refute_exists cf.pathname
      
      output = cf.readlines
      assert_exists cf.pathname

      fromgz = read_gzfile cf.pathname
      assert_equal output, fromgz
    end

    def test_reads_gzfile
      cf = get_cache_file [ "ls", "-l", "/var/tmp" ]
      rm_cached_file cf
      refute_exists cf.pathname

      execlines = cf.readlines
      assert_exists cf.pathname

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
end
