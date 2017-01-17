#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/common/options_tc'
require 'svnx/status/options'

class Svnx::Status::OptionsTest < Svnx::CommonOptionsTestCase
  def options_class
    Svnx::Status::Options
  end
  
  def test_default
    defexpected = {
      paths: nil,
      url: nil
    }
    assert_options defexpected
  end
  
  def test_paths
    assert_assign paths: [ "a/b", "c/d" ]
  end 
  
  def test_url
    assert_assign url: "p://a/b"
  end 
end
