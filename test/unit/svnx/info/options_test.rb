#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'
require 'svnx/common/options_tc'

class Svnx::Info::OptionsTest < Svnx::CommonOptionsTestCase
  def options_class
    Svnx::Info::Options
  end
    
  def test_default
    defexpected = {
      revision: nil,
      url: nil,
      path: nil,
    }
    assert_options defexpected
  end
  
  def test_revision
    assert_assign revision: "123:456"
  end
  
  def test_path
    assert_assign path: "a/b"
  end 
  
  def test_url
    assert_assign url: "p://a/b"
  end 
end
