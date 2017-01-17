#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/common/options_tc'
require 'svnx/merge/options'

class Svnx::Merge::OptionsTest < Svnx::CommonOptionsTestCase
  def options_class
    Svnx::Merge::Options
  end
  
  def test_default
    defexpected = {
      commit: nil,
      range: nil,
      accept: nil,
      path: nil,
      url: nil
    }
    assert_options defexpected
  end
  
  def test_commit
    assert_assign commit: 123
  end
  
  def test_range
    assert_assign range: "123:456"
  end
  
  def test_accept
    assert_assign accept: "postpone"
  end 
  
  def test_path
    assert_assign path: "a/b"
  end 
  
  def test_url
    assert_assign url: "p://a/b"
  end 
end
