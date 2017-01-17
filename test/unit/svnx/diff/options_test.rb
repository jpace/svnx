#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/common/options_tc'
require 'svnx/diff/options'

class Svnx::Diff::OptionsTest < Svnx::CommonOptionsTestCase
  def options_class
    Svnx::Diff::Options
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
    assert_assign commit: 123
  end
  
  def test_ignoreproperties_true
    assert_assign ignoreproperties: true
  end
  
  def test_ignoreproperties_false
    assert_assign ignoreproperties: false
  end
  
  def test_ignorewhitespace_true
    assert_assign ignorewhitespace: true
  end
  
  def test_ignorewhitespace_false
    assert_assign ignorewhitespace: false
  end 

  def test_url
    assert_options({ url: "p://xyz", path: nil }, url: "p://xyz")
  end

  def test_path
    assert_options({ path: "a/b", url: nil }, path: "a/b")
  end
end
