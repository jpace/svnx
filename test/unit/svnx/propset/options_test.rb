#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/options'
require 'svnx/common/options_tc'

class Svnx::Propset::OptionsTest < Svnx::CommonOptionsTestCase
  def options_class
    Svnx::Propset::Options
  end
    
  def test_default
    defexpected = {
      file: nil,
      revision: nil,
      revprop: nil,
      url: nil,
      path: nil,
    }
    assert_options defexpected
  end
  
  def test_file
    assert_assign file: "abc"
  end
  
  def test_revision
    assert_assign revision: "123:456"
  end
  
  def test_revprop
    assert_assign revprop: true
  end 
  
  def test_name
    assert_assign name: "abc"
  end 
  
  def test_value
    assert_assign value: "def"
  end 
  
  def test_path
    assert_assign path: "a/b"
  end 
  
  def test_url
    assert_assign url: "p://a/b"
  end 
end
