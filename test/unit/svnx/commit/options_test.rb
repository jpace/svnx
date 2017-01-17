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
    assert_options({ file: "x/y" }, file: "x/y")
  end 
  
  def test_paths
    assert_options({ paths: [ "a/b", "c/d" ] }, paths: [ "a/b", "c/d" ])
  end 
  
  def test_url
    assert_options({ url: "p://a/b" }, url: "p://a/b")
  end 
end
