#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'
require 'svnx/common/options_tc'

class SvnInfoOptionsTest < SvnCommonOptionsTestCase
  def options_class
    SvnInfoOptions
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
    assert_options({ revision: "123:456" }, revision: "123:456")
  end
  
  def test_path
    assert_options({ path: "a/b" }, path: "a/b")
  end 
  
  def test_url
    assert_options({ url: "p://a/b" }, url: "p://a/b")
  end 
end
