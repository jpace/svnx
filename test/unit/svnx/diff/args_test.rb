#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/diff/args'

class TestSvnDiffArgs < Test::Unit::TestCase
  def create_options optargs = Hash.new
    SvnDiffOptions.new optargs
  end

  def create_args options
    SvnDiffArgs.new options
  end
  
  def assert_to_svn_args expected, optargs = Hash.new
    opts = create_options optargs
    create_args(opts).tap do |args|
      assert_equal expected, args.to_svn_args, "optargs: #{optargs}"
    end
  end
  
  def test_default
    assert_to_svn_args Array.new
  end
  
  def test_commit
    assert_to_svn_args [ "-c", 123 ], commit: 123
  end
  
  def test_ignoreproperties_true
    assert_to_svn_args [ "--ignore-properties" ], ignoreproperties: true
  end
  
  def test_ignoreproperties_false
    assert_to_svn_args Array.new, ignoreproperties: false
  end
  
  def test_ignorewhitespace_true
    assert_to_svn_args [ "-x", "-bw" ], ignorewhitespace: true
  end
  
  def test_ignorewhitespace_false
    assert_to_svn_args Array.new, ignorewhitespace: false
  end

  def test_url
    assert_to_svn_args [ "p://xyz" ], url: "p://xyz"
  end

  def test_path
    assert_to_svn_args [ "a/b" ], path: "a/b"
  end
end
