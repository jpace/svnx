#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'pathname'
require 'svnx/diff/options'

class SvnDiffOptionsTest < Test::Unit::TestCase
  def test_default
    opts = SvnDiffOptions.new
    assert_equal nil, opts.commit
    assert_equal nil, opts.ignoreproperties
    assert_equal nil, opts.ignorewhitespace
  end
  
  def test_commit
    opts = SvnDiffOptions.new commit: 123
    assert_equal 123, opts.commit
  end
  
  def test_ignoreproperties_true
    opts = SvnDiffOptions.new ignoreproperties: true
    assert_equal true, opts.ignoreproperties
  end
  
  def test_ignoreproperties_false
    opts = SvnDiffOptions.new ignoreproperties: false
    assert_equal false, opts.ignoreproperties
  end
  
  def test_ignorewhitespace_true
    opts = SvnDiffOptions.new ignorewhitespace: true
    assert_equal true, opts.ignorewhitespace
  end
  
  def test_ignorewhitespace_false
    opts = SvnDiffOptions.new ignorewhitespace: false
    assert_equal false, opts.ignorewhitespace
  end
  
end
