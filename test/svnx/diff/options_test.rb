#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/options/tc'

class Svnx::Diff::OptionsTest < Svnx::Options::TestCase
  def options_class
    Svnx::Diff::Options
  end
  
  def test_assign_default
    defexpected = { commit: nil,
                    ignoreproperties: nil,
                    ignorewhitespace: nil,
                    paths: nil,
                    url: nil }
    assert_options defexpected
  end
  
  def test_assign_commit
    assert_assign commit: 123
  end
  
  def test_assign_ignoreproperties_true
    assert_assign ignoreproperties: true
  end
  
  def test_assign_ignoreproperties_false
    assert_assign ignoreproperties: false
  end
  
  def test_assign_ignorewhitespace_true
    assert_assign ignorewhitespace: true
  end
  
  def test_assign_ignorewhitespace_false
    assert_assign ignorewhitespace: false
  end 

  def test_assign_url
    assert_options({ url: "p://xyz", paths: nil }, url: "p://xyz")
  end

  def test_assign_paths
    assert_options({ paths: [ "a/b" ], url: nil }, paths: [ "a/b" ])
  end

  # to_args
  
  def test_to_args_default
    assert_to_args Array.new
  end
  
  def test_to_args_commit
    assert_to_args [ "-c", 123 ], commit: 123
  end
  
  def test_to_args_ignoreproperties_true
    assert_to_args [ "--ignore-properties" ], ignoreproperties: true
  end
  
  def test_to_args_ignoreproperties_false
    assert_to_args Array.new, ignoreproperties: false
  end
  
  def test_to_args_ignorewhitespace_true
    assert_to_args [ "-x", "-bw" ], ignorewhitespace: true
  end
  
  def test_to_args_ignorewhitespace_false
    assert_to_args Array.new, ignorewhitespace: false
  end

  def test_to_args_url
    assert_to_args [ "p://xyz" ], url: "p://xyz"
  end

  def test_to_args_paths_one
    assert_to_args [ "a/b" ], paths: [ "a/b" ]
  end
  
  def test_to_args_paths_two
    assert_to_args [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ]
  end
  
  def test_to_args_depth_empty
    assert_to_args [ "--depth", "empty" ], depth: "empty"
  end
  
end
