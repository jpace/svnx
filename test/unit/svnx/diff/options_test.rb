#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/common/options_tc'
require 'svnx/diff/options'

class SvnDiffOptionsTest < SvnCommonOptionsTestCase
  def options_class
    SvnDiffOptions
  end
  
  def test_default
    defexpected = { commit: nil,
                    ignoreproperties: nil,
                    ignorewhitespace: nil,
                    path: nil,
                    url: nil }
    assert_options defexpected
  end
  
  def test_commit
    assert_options({ commit: 123 }, commit: 123)
  end
  
  def test_ignoreproperties_true
    assert_options({ ignoreproperties: true }, ignoreproperties: true)
  end
  
  def test_ignoreproperties_false
    assert_options({ ignoreproperties: false }, ignoreproperties: false)
  end
  
  def test_ignorewhitespace_true
    assert_options({ ignorewhitespace: true }, ignorewhitespace: true)
  end
  
  def test_ignorewhitespace_false
    assert_options({ ignorewhitespace: false }, ignorewhitespace: false);
  end 

  def test_url
    assert_options({ url: "p://xyz", path: nil }, url: "p://xyz")
  end

  def test_path
    assert_options({ path: "a/b", url: nil }, path: "a/b")
  end
end
