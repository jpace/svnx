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
    assert_options({ file: "abc" }, file: "abc")
  end
  
  def test_revision
    assert_options({ revision: "123:456" }, revision: "123:456")
  end
  
  def test_revprop
    assert_options({ revprop: true }, revprop: true)
  end 
  
  def test_name
    assert_options({ name: "abc" }, name: "abc")
  end 
  
  def test_value
    assert_options({ value: "def" }, value: "def")
  end 
  
  def test_path
    assert_options({ path: "a/b" }, path: "a/b")
  end 
  
  def test_url
    assert_options({ url: "p://a/b" }, url: "p://a/b")
  end 
end
