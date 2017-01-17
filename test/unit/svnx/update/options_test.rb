#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/common/options_tc'
require 'svnx/update/options'

class Svnx::Update::OptionsTest < Svnx::CommonOptionsTestCase
  def options_class
    Svnx::Update::Options
  end
  
  def test_default
    defexpected = {
      revision: nil,
      paths: nil,
      url: nil
    }
    assert_options defexpected
  end
  
  def test_revision
    assert_options({ revision: 123 }, revision: 123)
  end 
  
  def test_paths
    assert_options({ paths: [ "a/b", "c/d" ] }, paths: [ "a/b", "c/d" ])
  end 
  
  def test_url
    assert_options({ url: "p://a/b" }, url: "p://a/b")
  end 
end
