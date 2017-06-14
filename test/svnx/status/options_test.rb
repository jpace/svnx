#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/options'
require 'svnx/options/tc'

class Svnx::Status::OptionsTest < Svnx::Options::TestCase
  def options_class
    Svnx::Status::Options
  end
  
  def test_assign_default
    defexpected = {
      paths: nil,
      url: nil
    }
    assert_options defexpected
  end
  
  def test_assign_paths
    assert_assign paths: [ "a/b", "c/d" ]
  end 
  
  def test_assign_url
    assert_assign url: "p://a/b"
  end

  def create_options optargs = Hash.new
    Svnx::Status::Options.new optargs
  end

  def create_args options
    Svnx::Status::Args.new options
  end
  
  def test_to_args_default
    assert_to_args Array.new
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
