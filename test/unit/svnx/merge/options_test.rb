#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/merge/options'

class SvnMergeOptionsTest < Test::Unit::TestCase
  def assert_options expvals, optvals = Hash.new
    opts = SvnMergeOptions.new optvals
    expvals.each do |methname, expval|
      val = opts.send methname
      assert_equal expval, val, "method: #{methname}"
    end
  end
  
  def test_default
    defexpected = { commit: nil,
                    range: nil,
                    accept: nil,
                    path: nil,
                    url: nil }
    assert_options defexpected
  end
  
  def test_commit
    assert_options({ commit: 123 }, commit: 123)
  end
  
  def test_range
    assert_options({ range: "123:456" }, range: "123:456")
  end
  
  def test_accept
    assert_options({ accept: "postpone" }, accept: "postpone")
  end 
  
  def test_path
    assert_options({ path: "a/b" }, path: "a/b")
  end 
  
  def test_url
    assert_options({ url: "p://a/b" }, url: "p://a/b")
  end 
end
