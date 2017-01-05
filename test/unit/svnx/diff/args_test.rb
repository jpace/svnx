#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/diff/args'

class TestArgs < Test::Unit::TestCase
  def test_default
    args = SvnDiffArgs.new
    assert_equal [], args.to_svn_args
  end
  
  def test_commit
    args = SvnDiffArgs.new commit: 123
    assert_equal [ "-c", 123 ], args.to_svn_args
  end
  
  def test_ignoreproperties_true
    args = SvnDiffArgs.new ignoreproperties: true
    assert_equal [ "--ignore-properties" ], args.to_svn_args
  end
  
  def test_ignoreproperties_false
    args = SvnDiffArgs.new ignoreproperties: false
    assert_equal [], args.to_svn_args
  end
  
  def test_ignorewhitespace_true
    args = SvnDiffArgs.new ignorewhitespace: true
    assert_equal [ "-x", "-bw" ], args.to_svn_args
  end
  
  def test_ignorewhitespace_false
    args = SvnDiffArgs.new ignorewhitespace: false
    assert_equal [], args.to_svn_args
  end
end
