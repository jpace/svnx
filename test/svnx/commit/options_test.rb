#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/options'
require 'svnx/options/tc'

class Svnx::Commit::OptionsTest < Svnx::Options::TestCase
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
  
  def test_to_args_default
    assert_to_args Array.new
  end
  
  def test_to_args_file
    assert_to_args [ "-F", "a/b" ], file: "a/b"
  end
  
  def test_to_args_url
    assert_to_args [ "p://abc" ], url: "p://abc"
  end

  def test_to_args_paths_single
    assert_to_args [ "a/b" ], paths: [ "a/b" ]
  end

  def test_to_args_paths_multiple
    assert_to_args [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ]
  end
end
