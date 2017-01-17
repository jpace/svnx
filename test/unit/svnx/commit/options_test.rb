#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/common/options_tc'
require 'svnx/commit/options'

class Svnx::Commit::OptionsTest < Svnx::CommonOptionsTestCase
  def options_class
    Svnx::Commit::Options
  end
  
  def test_default
    defexpected = {
      file: nil,
      paths: nil,
      url: nil
    }
    assert_options defexpected
  end
  
  def test_file
    assert_assign file: "x/y"
  end 
  
  def test_paths
    assert_assign paths: [ "a/b", "c/d" ]
  end 
  
  def test_url
    assert_assign url: "p://a/b"
  end 
end
