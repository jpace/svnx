#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'
require 'zlib'
require 'pathname'

module CmdLine
end

class CmdLine::CommandTestCase < Svnx::TestCase
  CACHE_DIR = Pathname.new '/tmp/pvn/testing'

  def rm_cache_dir
    CACHE_DIR.rmtree if CACHE_DIR.exist?
  end

  def setup
    super
    rm_cache_dir
  end

  def teardown
    super
    rm_cache_dir
  end

  def read_gzfile gzfile
    lines = nil
    Zlib::GzipReader.open(gzfile.to_s) do |gz|
      lines = gz.readlines
    end
    lines
  end
end
