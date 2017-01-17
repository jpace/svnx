#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/common/args_tc'
require 'svnx/commit/args'

class Svnx::Commit::ArgsTest < Svnx::CommonArgsTestCase
  def create_options optargs = Hash.new
    Svnx::Commit::Options.new optargs
  end

  def create_args options
    Svnx::Commit::Args.new options
  end
  
  def test_default
    assert_to_svn_args Array.new
  end
  
  def test_file
    assert_to_svn_args [ "-F", "a/b" ], file: "a/b"
  end
  
  def test_url
    assert_to_svn_args [ "p://abc" ], url: "p://abc"
  end

  def test_paths_single
    assert_to_svn_args [ "a/b" ], paths: [ "a/b" ]
  end

  def test_paths_multiple
    assert_to_svn_args [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ]
  end
end
