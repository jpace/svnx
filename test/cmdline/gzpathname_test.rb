#!/usr/bin/ruby -w
# -*- ruby -*-

require 'cmdline/gzpathname'
require 'svnx/tc'
require 'tempfile'

Logue::Log.level = Logue::Log::WARN

module CmdLine
  class GzipPathnameTestCase < Svnx::TestCase

    def test_save_file
      tempfile = Tempfile.new [ "gzippathname", ".gz" ]
      pn = GzipPathname.new tempfile.path
      if pn.exist?
        pn.unlink
      end
      assert_equal false, pn.exist?
      
      pn.save_file %w{ abc }
      assert_equal true, pn.exist?
      content = read_gunzip pn.to_s
      assert_equal [ "abc\n" ], content
    end

    def read_gunzip fname
      IO.popen("gunzip -c #{fname}") do |io|
        io.readlines
      end
    end

    def write_gzip fname, content
      IO.popen("echo #{content} > #{fname}; gzip #{fname}") do |io|
        io.readlines
      end
    end

    def test_read_file
      tempfile = Tempfile.new "gzippathname"
      temppath = tempfile.path

      write_gzip temppath, "def"
      
      pn = GzipPathname.new temppath + ".gz"
      content = pn.read_file
      assert_equal [ "def\n" ], content
    end

    def test_read_file_does_not_exist
      pn = GzipPathname.new "/tmp/ahighlyunlikelyname-317"
      begin
        pn.read_file
        fail "should have been an exception"
      rescue Errno::ENOENT
        # good
      end
    end
  end
end
