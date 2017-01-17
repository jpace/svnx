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
    assert_assign revision: 123
  end 
  
  def test_paths
    assert_assign paths: [ "a/b", "c/d" ]
  end 
  
  def test_url
    assert_assign url: "p://a/b"
  end
end
